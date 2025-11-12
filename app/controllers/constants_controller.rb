class ConstantsController < ApplicationController
  before_action :set_constant, only: %i[edit update destroy]

  ConstantRecord = Struct.new(
                     :patient_name, :gender, :age,
                     :constant_type, :value, :symbol,
                     :measured_at, :health_state, :interpretation
                   )

  def index
    @constants = Constant.all.order(date_time_taken: :desc)
  end

  def show
    results = Constant.joins(:patient, :type_constant, :unit_of_measurement)
                      .where(id: params[:id])
                      .pluck(
                        "patient.name", :gender, :age, "type_constant.name",
                        :value, :symbol, :date_time_taken,
                        "type_constant.state", :notes
                      )

    @described_reading = results.map { |row| ConstantRecord.new(*row).to_h }
  end

  def new
    @constant = Constant.new
  end

  def create
    @constant = Constant.new(processed_constant_params)

    if @constant.save
      redirect_to root_path, notice: "Toma registrada correctamente"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    @constant.update(processed_constant_params)

    if @constant.save
      redirect_to root_path, notice: "Toma actualizada correctamente"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @constant.destroy

    redirect_to root_path, notice: "Toma eliminada correctamente"
  end

  private

  def set_constant
    @constant = Constant.find(params[:id])
  end

  def processed_constant_params
    permitted = params.require(:constant).permit(
      :patient_id,
      :type_constant_id,
      :unit_of_measurement_id,
      :value,
      :date_time_taken,
      :date,
      :time,
      :notes
    )

    if permitted[:date].present? && permitted[:time].present?
      datetime_str = "#{permitted[:date]} #{permitted[:time]}"
      permitted[:date_time_taken] = Time.zone.parse(datetime_str)
    end

    permitted.except(:date, :time)
  end
end
