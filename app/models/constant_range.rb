class ConstantRange < ApplicationRecord
  belongs_to :constant_type

  validates :state, :description, presence: true
  validates :priority, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :valid_range

  private

  def valid_range
    return if min_value.nil? && max_value.nil?

    if min_value.present? && max_value.present? && min_value > max_value
      errors.add(:min_value, "no puede ser mayor que max_value")
    end
  end
end
