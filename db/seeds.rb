# 🧩 Limpieza de datos previos
puts "🧹 Limpiando base de datos..."
Constant.destroy_all
TypeConstant.destroy_all
UnitOfMeasurement.destroy_all
Patient.destroy_all

puts "✅ Base limpia."

# ==========================================================
# 🧱 Unidades de medida
# ==========================================================

puts "📏 Creando unidades de medida..."

units = {
  celsius: UnitOfMeasurement.create!(name: "Grado Celsius", symbol: "°C"),
  bpm: UnitOfMeasurement.create!(name: "Latidos por minuto", symbol: "bpm"),
  rpm: UnitOfMeasurement.create!(name: "Respiraciones por minuto", symbol: "rpm"),
  mmhg: UnitOfMeasurement.create!(name: "Milímetros de mercurio", symbol: "mmHg"),
  percent: UnitOfMeasurement.create!(name: "Porcentaje de saturación", symbol: "%"),
  imc: UnitOfMeasurement.create!(name: "Índice de masa corporal", symbol: "kg/m²")
}

puts "✅ Unidades creadas: #{UnitOfMeasurement.count}"

# ==========================================================
# ⚕️ Tipos de constantes médicas
# ==========================================================

puts "🧠 Creando tipos de constantes médicas..."

type_constants = {
  temperatura: TypeConstant.create!(
    name: "Temperatura corporal",
    description: "Temperatura del cuerpo medida en °C",
    min_value: 35.0,
    max_value: 37.4,
    state: "Normal"
  ),
  frecuencia_cardiaca: TypeConstant.create!(
    name: "Frecuencia cardiaca",
    description: "Número de latidos por minuto (bpm)",
    min_value: 60,
    max_value: 100,
    state: "Normal"
  ),
  frecuencia_respiratoria: TypeConstant.create!(
    name: "Frecuencia respiratoria",
    description: "Número de respiraciones por minuto (rpm)",
    min_value: 12,
    max_value: 20,
    state: "Normal"
  ),
  presion_arterial: TypeConstant.create!(
    name: "Presión arterial",
    description: "Medición de presión sanguínea sistólica/diastólica (mmHg)",
    min_value: 90,
    max_value: 120,
    state: "Normal"
  ),
  saturacion_oxigeno: TypeConstant.create!(
    name: "Saturación de oxígeno (SpO₂)",
    description: "Porcentaje de oxígeno en la sangre",
    min_value: 95,
    max_value: 100,
    state: "Normal"
  ),
  imc: TypeConstant.create!(
    name: "Índice de Masa Corporal (IMC)",
    description: "Relación entre peso y estatura (kg/m²)",
    min_value: 18.5,
    max_value: 24.9,
    state: "Normal"
  ),
  presion_pulso: TypeConstant.create!(
    name: "Presión del pulso",
    description: "Diferencia entre presión sistólica y diastólica",
    min_value: 30,
    max_value: 50,
    state: "Normal"
  )
}

puts "✅ Tipos de constantes creados: #{TypeConstant.count}"

# ==========================================================
# 🧍 Pacientes de ejemplo
# ==========================================================

puts "👩‍⚕️ Creando pacientes de ejemplo..."

patients = [
  Patient.create!(name: "Juan Pérez", gender: "Masculino", age: 30),
  Patient.create!(name: "Ana Gómez", gender: "Femenino", age: 25),
  Patient.create!(name: "Carlos Martínez", gender: "Masculino", age: 45)
]

puts "✅ Pacientes creados: #{Patient.count}"

# ==========================================================
# 📊 Constantes registradas
# ==========================================================

puts "📈 Creando mediciones (constants)..."

Constant.create!([
  {
    patient: patients[0],
    type_constant: type_constants[:temperatura],
    unit_of_measurement: units[:celsius],
    value: 36.8,
    notes: "Normal, sin fiebre",
    date_time_taken: rand(30).days.ago
  },
  {
    patient: patients[0],
    type_constant: type_constants[:frecuencia_cardiaca],
    unit_of_measurement: units[:bpm],
    value: 72,
    notes: "Frecuencia cardíaca normal",
    date_time_taken: rand(30).days.ago
  },
  {
    patient: patients[0],
    type_constant: type_constants[:presion_arterial],
    unit_of_measurement: units[:mmhg],
    value: 118,
    notes: "Presión dentro del rango normal",
    date_time_taken: rand(30).days.ago
  },
  {
    patient: patients[1],
    type_constant: type_constants[:temperatura],
    unit_of_measurement: units[:celsius],
    value: 38.5,
    notes: "Fiebre moderada",
    date_time_taken: rand(30).days.ago
  },
  {
    patient: patients[1],
    type_constant: type_constants[:frecuencia_respiratoria],
    unit_of_measurement: units[:rpm],
    value: 22,
    notes: "Ligera taquipnea",
    date_time_taken: rand(30).days.ago
  },
  {
    patient: patients[2],
    type_constant: type_constants[:imc],
    unit_of_measurement: units[:imc],
    value: 31.2,
    notes: "Obesidad grado I",
    date_time_taken: rand(30).days.ago
  },
  {
    patient: patients[2],
    type_constant: type_constants[:saturacion_oxigeno],
    unit_of_measurement: units[:percent],
    value: 93,
    notes: "Leve hipoxemia",
    date_time_taken: rand(30).days.ago
  }
])

puts "✅ Constantes registradas: #{Constant.count}"

puts "🎉 SEED COMPLETO: Base de datos lista para pruebas."
