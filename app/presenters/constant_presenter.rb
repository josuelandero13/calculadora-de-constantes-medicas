class ConstantPresenter
  delegate :patient, :constant_type, :unit_of_measurement, :value, :date_time_taken, :calculated_state, :notes, to: :@constant

  def initialize(constant)
    @constant = constant
  end

  def patient_name
    patient.name
  end

  def gender
    patient.gender
  end

  def age
    patient.age
  end

  def constant_type_name
    constant_type.name
  end

  def symbol
    unit_of_measurement&.symbol
  end

  def measured_at
    date_time_taken
  end

  def interpretation
    notes
  end

  attr_reader :constant
end
