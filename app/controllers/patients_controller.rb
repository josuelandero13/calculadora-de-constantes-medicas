class PatientsController < ApplicationController
  def index; end

  def show; end

  def new; end

  def create; end

  def edit; end

  def update; end

  def destroy; end

  def search
    @patients = Patient.where("name ILIKE ?", "%#{params[:query]}%").limit(10)

    render partial: "patients/search_results", locals: { patients: @patients }
  end
end
