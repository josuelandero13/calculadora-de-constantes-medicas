# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_11_13_030130) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "constant_ranges", force: :cascade do |t|
    t.bigint "constant_type_id", null: false
    t.string "state", null: false
    t.text "description", null: false
    t.decimal "min_value", precision: 10, scale: 2
    t.decimal "max_value", precision: 10, scale: 2
    t.integer "priority", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color_class", default: "bg-gray-400", null: false
    t.index ["color_class"], name: "index_constant_ranges_on_color_class"
    t.index ["constant_type_id", "min_value", "max_value"], name: "idx_on_constant_type_id_min_value_max_value_7fb9d2ad0a"
    t.index ["constant_type_id", "priority"], name: "index_constant_ranges_on_constant_type_id_and_priority"
    t.index ["constant_type_id"], name: "index_constant_ranges_on_constant_type_id"
  end

  create_table "constant_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "unit"
  end

  create_table "constants", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.bigint "constant_type_id", null: false
    t.bigint "unit_of_measurement_id"
    t.decimal "value", precision: 10, scale: 2, null: false
    t.datetime "date_time_taken", default: -> { "CURRENT_TIMESTAMP" }
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "calculated_state"
    t.index ["constant_type_id"], name: "index_constants_on_constant_type_id"
    t.index ["patient_id"], name: "index_constants_on_patient_id"
    t.index ["unit_of_measurement_id"], name: "index_constants_on_unit_of_measurement_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "name", null: false
    t.string "gender", null: false
    t.integer "age", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.check_constraint "gender::text = ANY (ARRAY['Masculino'::character varying::text, 'Femenino'::character varying::text, 'Otro'::character varying::text])", name: "gender_check"
  end

  create_table "unit_of_measurements", force: :cascade do |t|
    t.string "name", null: false
    t.string "symbol", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "constant_ranges", "constant_types", on_delete: :cascade
  add_foreign_key "constants", "constant_types"
  add_foreign_key "constants", "patients", on_delete: :cascade
  add_foreign_key "constants", "unit_of_measurements"
end
