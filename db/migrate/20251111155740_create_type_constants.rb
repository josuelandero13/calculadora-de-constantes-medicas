class CreateTypeConstants < ActiveRecord::Migration[7.2]
  def change
    create_table :type_constants do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.decimal :min_value, precision: 10, scale: 2
      t.decimal :max_value, precision: 10, scale: 2
      t.string :state, null: false

      t.timestamps
    end
  end
end
