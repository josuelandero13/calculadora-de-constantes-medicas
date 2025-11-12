class MakeUnitOfMeasurementOptionalInConstants < ActiveRecord::Migration[7.2]
  def change
    change_column_null :constants, :unit_of_measurement_id, true
  end
end
