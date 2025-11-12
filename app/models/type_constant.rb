class TypeConstant < ApplicationRecord
  has_many :constants
  belongs_to :unit_of_measurement

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :state, presence: true
  validates :min_value, numericality: { less_than: :max_value }
  validates :max_value, numericality: { greater_than: :min_value }

  scope :with_unit_symbol, -> {
    joins(:unit_of_measurement)
      .select("type_constants.*, unit_of_measurements.symbol as unit_symbol")
  }
end
