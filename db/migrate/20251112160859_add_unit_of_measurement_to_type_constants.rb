class AddUnitOfMeasurementToTypeConstants < ActiveRecord::Migration[7.2]
  def change
    add_reference :type_constants, :unit_of_measurement, foreign_key: true
  end
end
