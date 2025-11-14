class ConstantsController < ApplicationController
  before_action :set_constant, only: %i[edit update destroy]

  ConstantRecord = Struct.new(
                     :patient_name, :gender, :age,
                     :constant_type, :value, :symbol,
                     :measured_at, :health_state, :interpretation
                   )

  def index
    @constants = FindConstants.new.call(params)
    @patients = Patient.all
    @constant_types = ConstantType.with_constants_count
  end

  def show
    constant = Constant.includes(:patient, :constant_type, :unit_of_measurement)
                      .find(params[:id])
    results = [
      constant.patient.name,
      constant.patient.gender,
      constant.patient.age,
      constant.constant_type.name,
      constant.value,
      constant.unit_of_measurement&.symbol,
      constant.date_time_taken,
      constant.calculated_state,
      constant.notes
    ]

    @described_reading = ConstantRecord.new(*results).to_h
  end

  def new
    @constant = Constant.new

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "constant_form",
          partial: "constants/form_modal",
          locals: { constant: @constant }
        )
      end
      format.html
    end
  end

  def create
    @constant = Constant.new(processed_constant_params)

    respond_to do |format|
    if @constant.save
      format.turbo_stream
      format.html { redirect_to constants_path, notice: "Toma creada exitosamente" }
    else
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "constant_form",
          partial: "constants/form_modal",
          locals: { constant: @constant }
        )
      end
      format.html { render :new, status: :unprocessable_entity }
    end
  end
  end

  def edit; end

  def update
    @constant.assign_attributes(processed_constant_params)

    if @constant.save
      redirect_to root_path, notice: "Toma actualizada exitosamente"
    else
      render :edit
    end
  end

  def destroy
    @constant.destroy

    redirect_to root_path, notice: "Toma eliminada correctamente"
  end

  private

  def close_modal
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("modal", "")
      end
    end
  end

  def set_constant
    @constant = Constant.find(params[:id])
  end

  def processed_constant_params
    permitted = params.require(:constant)
                      .permit(
                        :patient_id, :constant_type_id, :value,
                        :notes, :date_time_taken, :date, :time
                      )

    if permitted[:date].present? && permitted[:time].present?
      datetime_str = "#{permitted[:date]} #{permitted[:time]}"
      permitted[:date_time_taken] = Time.zone.parse(datetime_str)
    end

    permitted.except(:date, :time)
  end
end
