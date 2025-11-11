class Constant < ApplicationRecord
  belongs_to :patient
  belongs_to :type_constant
  belongs_to :unit_of_measurement

  validates :value, presence: true, numericality: true
  validates :date_time_taken, presence: true
end
