class Constant < ApplicationRecord
  belongs_to :patient
  belongs_to :type_constant
  belongs_to :unit_of_measurement, optional: true

  validates :value, presence: true, numericality: true
  validates :date_time_taken, presence: true

  before_validation :assign_unit_from_type_constant

  private

  def assign_unit_from_type_constant
    self.unit_of_measurement ||= type_constant&.unit_of_measurement
  end
end
