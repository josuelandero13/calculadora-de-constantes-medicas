class ConstantsController < ApplicationController
  ConstantRecord = Struct.new(
                     :patient_name, :gender, :age,
                     :constant_type, :value, :symbol,
                     :measured_at, :health_state, :interpretation
                   )

  def index
    @constants = Constant.all
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
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to constants_path, notice: "Constante creada correctamente." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @constant = Constant.find(params[:id])
  end

 def update; end

  def destroy; end

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
