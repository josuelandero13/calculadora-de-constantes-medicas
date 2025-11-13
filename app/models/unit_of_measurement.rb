class UnitOfMeasurement < ApplicationRecord
  has_many :constants, dependent: :nullify

  validates :name, :symbol, presence: true, uniqueness: true
end
