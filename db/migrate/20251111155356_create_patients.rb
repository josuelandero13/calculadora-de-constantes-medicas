class CreatePatients < ActiveRecord::Migration[7.2]
  def change
    create_table :patients do |t|
      t.string :name, null: false
      t.string :gender, null: false
      t.integer :age, null: false

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE patients
          ADD CONSTRAINT gender_check CHECK (gender IN ('Masculino', 'Femenino', 'Otro'));
        SQL
      end
    end
  end
end
