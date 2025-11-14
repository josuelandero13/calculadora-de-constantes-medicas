class Constant < ApplicationRecord
  belongs_to :patient
  belongs_to :constant_type
  belongs_to :unit_of_measurement, optional: true

  before_save :calculate_state

  validates :value, presence: true, numericality: true
  validates :date_time_taken, presence: true

  delegate :name, :gender, :age, to: :patient, prefix: true
  delegate :name, :unit, to: :constant_type, prefix: true
  delegate :symbol, to: :unit_of_measurement, prefix: true, allow_nil: true

  def measured_at
    date_time_taken&.strftime("%d/%m/%Y %H:%M")
  end

  def value_with_unit
    [ value, constant_type_unit.presence ].compact.join(" ")
  end

  private

  def calculate_state
    return unless constant_type.present?

    range = constant_type.find_range_for_value(value)
    self.calculated_state = range&.state
  end
end
