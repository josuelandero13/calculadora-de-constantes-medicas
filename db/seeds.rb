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
# ⚕️ Tipos de constantes médicas (CON UNIDADES ASIGNADAS)
# ==========================================================

puts "🧠 Creando tipos de constantes médicas..."

type_constants = {
  temperatura: TypeConstant.create!(
    name: "Temperatura corporal",
    description: "Temperatura del cuerpo medida en °C",
    min_value: 35.0,
    max_value: 37.4,
    state: "Normal",
    unit_of_measurement: units[:celsius]
  ),
  frecuencia_cardiaca: TypeConstant.create!(
    name: "Frecuencia cardiaca",
    description: "Número de latidos por minuto (bpm)",
    min_value: 60,
    max_value: 100,
    state: "Normal",
    unit_of_measurement: units[:bpm]
  ),
  frecuencia_respiratoria: TypeConstant.create!(
    name: "Frecuencia respiratoria",
    description: "Número de respiraciones por minuto (rpm)",
    min_value: 12,
    max_value: 20,
    state: "Normal",
    unit_of_measurement: units[:rpm]
  ),
  presion_arterial_sistolica: TypeConstant.create!(
    name: "Presión arterial sistólica",
    description: "Presión arterial en fase de contracción (mmHg)",
    min_value: 90,
    max_value: 120,
    state: "Normal",
    unit_of_measurement: units[:mmhg]
  ),
  presion_arterial_diastolica: TypeConstant.create!(
    name: "Presión arterial diastólica",
    description: "Presión arterial en fase de relajación (mmHg)",
    min_value: 60,
    max_value: 80,
    state: "Normal",
    unit_of_measurement: units[:mmhg]
  ),
  saturacion_oxigeno: TypeConstant.create!(
    name: "Saturación de oxígeno (SpO₂)",
    description: "Porcentaje de oxígeno en la sangre",
    min_value: 95,
    max_value: 100,
    state: "Normal",
    unit_of_measurement: units[:percent]
  ),
  imc: TypeConstant.create!(
    name: "Índice de Masa Corporal (IMC)",
    description: "Relación entre peso y estatura (kg/m²)",
    min_value: 18.5,
    max_value: 24.9,
    state: "Normal",
    unit_of_measurement: units[:imc]
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
  Patient.create!(name: "Carlos Martínez", gender: "Masculino", age: 45),
  Patient.create!(name: "María López", gender: "Femenino", age: 35),
  Patient.create!(name: "Pedro Rodríguez", gender: "Masculino", age: 28)
]

puts "✅ Pacientes creados: #{Patient.count}"

# ==========================================================
# 📊 Constantes registradas (SIN ESPECIFICAR unit_of_measurement - SE ASIGNA AUTOMÁTICAMENTE)
# ==========================================================

puts "📈 Creando mediciones (constants)..."

Constant.create!([
  {
    patient: patients[0],
    type_constant: type_constants[:temperatura],
    value: 36.8,
    notes: "Normal, sin fiebre",
    date_time_taken: rand(30).days.ago
  },
  {
    patient: patients[0],
    type_constant: type_constants[:frecuencia_cardiaca],
    value: 72,
    notes: "Frecuencia cardíaca normal",
    date_time_taken: rand(30).days.ago
  },
  {
    patient: patients[0],
    type_constant: type_constants[:presion_arterial_sistolica],
    value: 118,
    notes: "Presión sistólica normal",
    date_time_taken: rand(30).days.ago
  },
  {
    patient: patients[0],
    type_constant: type_constants[:presion_arterial_diastolica],
    value: 78,
    notes: "Presión diastólica normal",
    date_time_taken: rand(30).days.ago
  },
  {
    patient: patients[1],
    type_constant: type_constants[:temperatura],
    value: 38.5,
    notes: "Fiebre moderada",
    date_time_taken: rand(30).days.ago
  },
  {
    patient: patients[1],
    type_constant: type_constants[:frecuencia_respiratoria],
    value: 22,
    notes: "Ligera taquipnea",
    date_time_taken: rand(30).days.ago
  },
  {
    patient: patients[2],
    type_constant: type_constants[:imc],
    value: 31.2,
    notes: "Obesidad grado I",
    date_time_taken: rand(30).days.ago
  },
  {
    patient: patients[2],
    type_constant: type_constants[:saturacion_oxigeno],
    value: 93,
    notes: "Leve hipoxemia",
    date_time_taken: rand(30).days.ago
  },
  {
    patient: patients[3],
    type_constant: type_constants[:frecuencia_cardiaca],
    value: 85,
    notes: "Ligera taquicardia",
    date_time_taken: rand(30).days.ago
  },
  {
    patient: patients[4],
    type_constant: type_constants[:imc],
    value: 22.5,
    notes: "Peso normal",
    date_time_taken: rand(30).days.ago
  }
])

puts "✅ Constantes registradas: #{Constant.count}"

# ==========================================================
# ✅ Verificación final
# ==========================================================

puts "\n" + "="*50
puts "✅ VERIFICACIÓN FINAL"
puts "="*50
puts "📊 Total Unidades de Medida: #{UnitOfMeasurement.count}"
puts "🧠 Total Tipos de Constantes: #{TypeConstant.count}"
puts "👥 Total Pacientes: #{Patient.count}"
puts "📈 Total Constantes: #{Constant.count}"

# Verificar que todas las constants tengan unidad de medida asignada
constants_sin_unidad = Constant.where(unit_of_measurement_id: nil)
puts "⚠️  Constants sin unidad: #{constants_sin_unidad.count}"

if constants_sin_unidad.any?
  puts "❌ ERROR: Hay constants sin unidad de medida asignada"
  constants_sin_unidad.each do |constant|
    puts "   - Constant ID: #{constant.id}, Type: #{constant.type_constant.name}"
  end
else
  puts "🎉 ¡TODAS LAS CONSTANTS TIENEN UNIDAD DE MEDIDA ASIGNADA!"
end

puts "\n🎉 SEED COMPLETO: Base de datos lista para desarrollo."

