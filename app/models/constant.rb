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

  scope :by_state, ->(state) { where(calculated_state: state) if state.present? }
  scope :by_type, ->(type_id) { where(constant_type_id: type_id) if type_id.present? }
  scope :by_patient, ->(patient_id) { where(patient_id: patient_id) if patient_id.present? }
  scope :in_date_range, ->(start_date, end_date) {
    query = all
    query = query.where("date_time_taken >= ?", start_date) if start_date.present?
    query = query.where("date_time_taken <= ?", end_date + " 23:59:59") if end_date.present?
    query
  }

  def measured_at
    date_time_taken&.strftime("%d/%m/%Y %H:%M")
  end

  def value_with_unit
    [ value, constant_type_unit.presence ].compact.join(" ")
  end

  attr_accessor :date, :time

  before_validation :set_date_time_taken

  private

  def calculate_state
    return unless constant_type.present?

    range = constant_type.find_range_for_value(value)
    self.calculated_state = range&.state
  end

  def set_date_time_taken
    if date.present? && time.present?
      self.date_time_taken = Time.zone.parse("#{date} #{time}")
    end
  end
end
