class Constant < ApplicationRecord
  belongs_to :patient
  belongs_to :constant_type
  belongs_to :unit_of_measurement, optional: true

  before_save :calculate_state

  validates :value, presence: true, numericality: true
  validates :date_time_taken, presence: true

  private

  def calculate_state
    return unless constant_type.present?

    range = constant_type.find_range_for_value(value)
    self.calculated_state = range&.state
  end
end
