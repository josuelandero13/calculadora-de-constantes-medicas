class RestructureConstantSystem < ActiveRecord::Migration[7.2]
  def change
    # 1. Renombrar type_constants a constant_types para mejor naming
    rename_table :type_constants, :constant_types

    # 2. Crear nueva tabla para los rangos
    create_table :constant_ranges do |t|
      t.references :constant_type, null: false, foreign_key: { on_delete: :cascade }
      t.string :state, null: false
      t.text :description, null: false
      t.decimal :min_value, precision: 10, scale: 2
      t.decimal :max_value, precision: 10, scale: 2
      t.integer :priority, default: 0
      t.timestamps
    end

    # 3. Migrar datos existentes de constant_types a constant_ranges
    reversible do |dir|
      dir.up do
        # Para cada type_constant existente, crear un constant_range
        execute <<-SQL
          INSERT INTO constant_ranges (constant_type_id, state, description, min_value, max_value, priority, created_at, updated_at)
          SELECT id, state, description, min_value, max_value, 1, NOW(), NOW()
          FROM constant_types;
        SQL
      end

      dir.down do
        # En caso de rollback, eliminar los rangos creados
        execute "DELETE FROM constant_ranges"
      end
    end

    # 4. Remover columnas que ahora están en constant_ranges
    remove_column :constant_types, :min_value
    remove_column :constant_types, :max_value
    remove_column :constant_types, :state
    remove_column :constant_types, :description

    # 5. Agregar unit a constant_types (para reemplazar la relación con unit_of_measurement)
    add_column :constant_types, :unit, :string

    # 6. Migrar la unidad de measurement a constant_types
    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE constant_types ct
          SET unit = uom.symbol
          FROM unit_of_measurements uom
          WHERE ct.unit_of_measurement_id = uom.id;
        SQL
      end
    end

    # 7. Remover la referencia a unit_of_measurement en constant_types
    remove_reference :constant_types, :unit_of_measurement

    # 8. Agregar calculated_state a constants
    add_column :constants, :calculated_state, :string

    # 9. Actualizar los calculated_state basado en los datos existentes
    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE constants c
          SET calculated_state = cr.state
          FROM constant_types ct
          JOIN constant_ranges cr ON ct.id = cr.constant_type_id
          WHERE c.type_constant_id = ct.id
          AND c.value BETWEEN COALESCE(cr.min_value, c.value) AND COALESCE(cr.max_value, c.value);
        SQL
      end
    end

    # 10. Renombrar la referencia en constants
    rename_column :constants, :type_constant_id, :constant_type_id

    # 11. Hacer unit_of_measurement_id opcional (ya lo hiciste, pero por si acaso)
    change_column_null :constants, :unit_of_measurement_id, true

    # Índices para mejor performance
    add_index :constant_ranges, [ :constant_type_id, :priority ]
    add_index :constant_ranges, [ :constant_type_id, :min_value, :max_value ]
  end
end
