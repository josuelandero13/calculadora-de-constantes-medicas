class CreateConstants < ActiveRecord::Migration[7.2]
  def change
    create_table :constants do |t|
      t.references :patient, null: false, foreign_key: { on_delete: :cascade }
      t.references :type_constant, null: false, foreign_key: true
      t.references :unit_of_measurement, null: false, foreign_key: true
      t.decimal :value, precision: 10, scale: 2, null: false
      t.datetime :date_time_taken, default: -> { 'CURRENT_TIMESTAMP' }
      t.text :notes

      t.timestamps
    end
  end
end
