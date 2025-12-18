class FindConstants
  attr_reader :constants

  def initialize(constants = initial_scope)
    @constants = constants
  end

  def call(params = {})
    constants
      .by_state(params[:state])
      .by_type(params[:type])
      .by_patient(params[:patient])
      .in_date_range(params[:start_date], params[:end_date])
      .order(updated_at: :desc)
  end

  private

  def initial_scope
    Constant.includes(:patient, :constant_type, :unit_of_measurement)
  end
end
