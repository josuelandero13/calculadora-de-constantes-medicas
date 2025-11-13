class ConstantType < ApplicationRecord
  has_many :constant_ranges, dependent: :destroy
  has_many :constants, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :unit, presence: true

  scope :with_unit_display, -> {
    select("constant_types.*, constant_types.unit as unit_symbol")
  }

  def find_range_for_value(value)
    constant_ranges.order(:priority).find do |range|
      (range.min_value.nil? || value >= range.min_value) &&
      (range.max_value.nil? || value <= range.max_value)
    end
  end
end
