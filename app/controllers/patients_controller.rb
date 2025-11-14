class PatientsController < ApplicationController
  before_action :set_patient, only: %i[show edit update destroy]

  def index
    @patients = Patient.all.order(updated_at: :desc)
  end

  def show; end

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)

    respond_to do |format|
      if @patient.save
        format.turbo_stream
        format.html { redirect_to root_path, notice: "Paciente creado exitosamente" }
      else
        format.html { render :new }
      end
    end
  end

  def edit; end

  def update
    if @patient.update(patient_params)
      redirect_to root_path, notice: "Paciente actualizado correctamente"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @patient.destroy
    redirect_to root_path, notice: "Paciente eliminado correctamente"
  end

  def search
    @patients = Patient.where("name ILIKE ?", "%#{params[:query]}%").limit(10)
    render partial: "patients/search_results", locals: { patients: @patients }
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(
      :name,
      :gender,
      :age
    )
  end
end
