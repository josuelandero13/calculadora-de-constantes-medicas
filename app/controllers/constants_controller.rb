class ConstantsController < ApplicationController
  def index
    @constants = Constant.all
  end
  def show; end

  def new; end

  def create; end

  def edit; end

  def update; end

  def destroy; end

  private

  def constant_params
    params.require(:constant).permit(
      :type_constant_id,
      :unit_of_measurement_id,
      :value,
      :date_time_taken,
      :notes
    )
  end
end
