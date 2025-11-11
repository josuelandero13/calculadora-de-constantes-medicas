class UnitOfMeasurement < ApplicationRecord
  has_many :constants, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
  validates :symbol, presence: true, uniqueness: true
end
