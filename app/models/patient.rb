class Patient < ApplicationRecord
  GENDERS = %w[ Masculino Femenino Otro ].freeze

  has_many :constants, dependent: :destroy

  validates :name, presence: true
  validates :gender, presence: true, inclusion: { in: GENDERS }
  validates :age, presence: true,
                  numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def self.for_select
    pluck(:id, :name, :age)
  end
end
