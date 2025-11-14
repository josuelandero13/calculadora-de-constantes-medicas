class FindConstants
  attr_reader :constants

  def initialize(constants = initial_scope)
    @constants = constants
  end

  def call(params = {})
    scoped = constants
    scoped = filter_by_state(scoped, params[:state])
    scoped = filter_by_type(scoped, params[:type])
    scoped = filter_by_patient(scoped, params[:patient])
    scoped = filter_by_start_date(scoped, params[:start_date])
    scoped = filter_by_end_date(scoped, params[:end_date])

    sort_by_updated_at(scoped)
  end

  private

  def initial_scope
    Constant.includes(:patient, :constant_type, :unit_of_measurement)
  end

  def filter_by_state(scoped, state)
    return scoped unless state.present?

    scoped.where(calculated_state: state)
  end

  def filter_by_type(scoped, type)
    return scoped unless type.present?

    scoped.where(constant_type_id: type)
  end

  def filter_by_patient(scoped, patient_id)
    return scoped unless patient_id.present?

    scoped.where(patient_id: patient_id)
  end

  def filter_by_start_date(scoped, start_date)
    return scoped unless start_date.present?

    scoped.where("date_time_taken >= ?", start_date)
  end

  def filter_by_end_date(scoped, end_date)
    return scoped unless end_date.present?

    scoped.where("date_time_taken <= ?", end_date + " 23:59:59")
  end

  def sort_by_updated_at(scoped)
    scoped.order(updated_at: :desc)
  end
end
