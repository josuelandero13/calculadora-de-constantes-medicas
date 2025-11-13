class AddColorClassToConstantRanges < ActiveRecord::Migration[7.2]
  def change
    add_column :constant_ranges, :color_class, :string, default: 'bg-gray-400', null: false
    add_index :constant_ranges, :color_class
  end
end
