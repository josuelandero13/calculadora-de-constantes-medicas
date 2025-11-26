class ConstantsController < ApplicationController
  before_action :set_constant, only: %i[edit update destroy]


  def index
    @constants = FindConstants.new.call(params)
    @patients = Patient.all
    @constant_types = ConstantType.with_constants_count
  end

  def show
    constant = Constant.includes(:patient, :constant_type, :unit_of_measurement)
                      .find(params[:id])
    @described_reading = ConstantPresenter.new(constant)
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
    @constant = Constant.new(constant_params)

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
    @constant.assign_attributes(constant_params)

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

  def constant_params
    params.require(:constant)
          .permit(
            :patient_id, :constant_type_id, :value,
            :notes, :date_time_taken, :date, :time
          )
  end
end
