# 🧩 Limpieza de datos previos
puts "🧹 Limpiando base de datos..."
Constant.destroy_all
ConstantRange.destroy_all
ConstantType.destroy_all
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
# ⚕️ Tipos de constantes médicas (CON UNIDAD DIRECTA)
# ==========================================================

puts "🧠 Creando tipos de constantes médicas..."

constant_types = {
  temperatura: ConstantType.create!(
    name: "Temperatura corporal",
    unit: "°C"
  ),
  frecuencia_cardiaca: ConstantType.create!(
    name: "Frecuencia cardiaca",
    unit: "bpm"
  ),
  frecuencia_respiratoria: ConstantType.create!(
    name: "Frecuencia respiratoria",
    unit: "rpm"
  ),
  presion_arterial_sistolica: ConstantType.create!(
    name: "Presión arterial sistólica",
    unit: "mmHg"
  ),
  presion_arterial_diastolica: ConstantType.create!(
    name: "Presión arterial diastólica",
    unit: "mmHg"
  ),
  saturacion_oxigeno: ConstantType.create!(
    name: "Saturación de oxígeno (SpO₂)",
    unit: "%"
  ),
  imc: ConstantType.create!(
    name: "Índice de Masa Corporal (IMC)",
    unit: "kg/m²"
  )
}

puts "✅ Tipos de constantes creados: #{ConstantType.count}"

# ==========================================================
# 📊 Rangos para cada tipo de constante
# ==========================================================

puts "🎯 Creando rangos de constantes..."

# Temperatura Corporal
ConstantRange.create!([
  {
    constant_type: constant_types[:temperatura],
    state: "Hipotermia Severa",
    description: "Temperatura corporal muy baja - riesgo vital",
    min_value: nil,
    max_value: 34.0,
    priority: 1,
    color_class: "bg-red-500"
  },
  {
    constant_type: constant_types[:temperatura],
    state: "Hipotermia",
    description: "Temperatura corporal baja",
    min_value: 34.1,
    max_value: 35.9,
    priority: 2,
    color_class: "bg-orange-500"
  },
  {
    constant_type: constant_types[:temperatura],
    state: "Normal",
    description: "Valor fisiológico normal",
    min_value: 36.0,
    max_value: 37.4,
    priority: 3,
    color_class: "bg-green-500"
  },
  {
    constant_type: constant_types[:temperatura],
    state: "Febrícula",
    description: "Temperatura ligeramente elevada",
    min_value: 37.5,
    max_value: 38.0,
    priority: 4,
    color_class: "bg-yellow-500"
  },
  {
    constant_type: constant_types[:temperatura],
    state: "Fiebre Moderada",
    description: "Estado febril",
    min_value: 38.1,
    max_value: 39.0,
    priority: 5,
    color_class: "bg-orange-500"
  },
  {
    constant_type: constant_types[:temperatura],
    state: "Fiebre Alta",
    description: "Riesgo alto, posible infección",
    min_value: 39.1,
    max_value: nil,
    priority: 6,
    color_class: "bg-red-500"
  }
])

# Frecuencia Cardíaca
ConstantRange.create!([
  {
    constant_type: constant_types[:frecuencia_cardiaca],
    state: "Bradicardia Severa",
    description: "Frecuencia muy baja - riesgo vital",
    min_value: nil,
    max_value: 40,
    priority: 1,
    color_class: "bg-red-500"
  },
  {
    constant_type: constant_types[:frecuencia_cardiaca],
    state: "Bradicardia",
    description: "Frecuencia baja",
    min_value: 41,
    max_value: 59,
    priority: 2,
    color_class: "bg-orange-500"
  },
  {
    constant_type: constant_types[:frecuencia_cardiaca],
    state: "Normal",
    description: "Rango normal en reposo",
    min_value: 60,
    max_value: 100,
    priority: 3,
    color_class: "bg-green-500"
  },
  {
    constant_type: constant_types[:frecuencia_cardiaca],
    state: "Taquicardia",
    description: "Frecuencia elevada",
    min_value: 101,
    max_value: 120,
    priority: 4,
    color_class: "bg-yellow-500"
  },
  {
    constant_type: constant_types[:frecuencia_cardiaca],
    state: "Taquicardia Severa",
    description: "Frecuencia muy elevada - riesgo vital",
    min_value: 121,
    max_value: nil,
    priority: 5,
    color_class: "bg-red-500"
  }
])

# Frecuencia Respiratoria
ConstantRange.create!([
  {
    constant_type: constant_types[:frecuencia_respiratoria],
    state: "Bradipnea",
    description: "Frecuencia respiratoria baja",
    min_value: nil,
    max_value: 11,
    priority: 1,
    color_class: "bg-orange-500"
  },
  {
    constant_type: constant_types[:frecuencia_respiratoria],
    state: "Normal",
    description: "Frecuencia respiratoria normal",
    min_value: 12,
    max_value: 20,
    priority: 2,
    color_class: "bg-green-500"
  },
  {
    constant_type: constant_types[:frecuencia_respiratoria],
    state: "Taquipnea",
    description: "Frecuencia respiratoria elevada",
    min_value: 21,
    max_value: nil,
    priority: 3,
    color_class: "bg-yellow-500"
  }
])

# Presión Arterial Sistólica
ConstantRange.create!([
  {
    constant_type: constant_types[:presion_arterial_sistolica],
    state: "Hipotensión",
    description: "Presión sistólica baja",
    min_value: nil,
    max_value: 89,
    priority: 1,
    color_class: "bg-orange-500"
  },
  {
    constant_type: constant_types[:presion_arterial_sistolica],
    state: "Normal",
    description: "Presión sistólica normal",
    min_value: 90,
    max_value: 120,
    priority: 2,
    color_class: "bg-green-500"
  },
  {
    constant_type: constant_types[:presion_arterial_sistolica],
    state: "Prehipertensión",
    description: "Presión sistólica elevada",
    min_value: 121,
    max_value: 139,
    priority: 3,
    color_class: "bg-yellow-500"
  },
  {
    constant_type: constant_types[:presion_arterial_sistolica],
    state: "Hipertensión",
    description: "Presión sistólica alta",
    min_value: 140,
    max_value: nil,
    priority: 4,
    color_class: "bg-red-500"
  }
])

# Presión Arterial Diastólica
ConstantRange.create!([
  {
    constant_type: constant_types[:presion_arterial_diastolica],
    state: "Hipotensión",
    description: "Presión diastólica baja",
    min_value: nil,
    max_value: 59,
    priority: 1,
    color_class: "bg-orange-500"
  },
  {
    constant_type: constant_types[:presion_arterial_diastolica],
    state: "Normal",
    description: "Presión diastólica normal",
    min_value: 60,
    max_value: 80,
    priority: 2,
    color_class: "bg-green-500"
  },
  {
    constant_type: constant_types[:presion_arterial_diastolica],
    state: "Prehipertensión",
    description: "Presión diastólica elevada",
    min_value: 81,
    max_value: 89,
    priority: 3,
    color_class: "bg-yellow-500"
  },
  {
    constant_type: constant_types[:presion_arterial_diastolica],
    state: "Hipertensión",
    description: "Presión diastólica alta",
    min_value: 90,
    max_value: nil,
    priority: 4,
    color_class: "bg-red-500"
  }
])

# Saturación de Oxígeno
ConstantRange.create!([
  {
    constant_type: constant_types[:saturacion_oxigeno],
    state: "Hipoxemia Severa",
    description: "Saturación crítica - riesgo vital",
    min_value: nil,
    max_value: 85,
    priority: 1,
    color_class: "bg-red-500"
  },
  {
    constant_type: constant_types[:saturacion_oxigeno],
    state: "Hipoxemia Moderada",
    description: "Saturación baja",
    min_value: 86,
    max_value: 90,
    priority: 2,
    color_class: "bg-orange-500"
  },
  {
    constant_type: constant_types[:saturacion_oxigeno],
    state: "Hipoxemia Leve",
    description: "Saturación ligeramente baja",
    min_value: 91,
    max_value: 94,
    priority: 3,
    color_class: "bg-yellow-500"
  },
  {
    constant_type: constant_types[:saturacion_oxigeno],
    state: "Normal",
    description: "Saturación normal",
    min_value: 95,
    max_value: 100,
    priority: 4,
    color_class: "bg-green-500"
  }
])

# IMC
ConstantRange.create!([
  {
    constant_type: constant_types[:imc],
    state: "Bajo Peso",
    description: "Peso inferior al normal",
    min_value: nil,
    max_value: 18.4,
    priority: 1,
    color_class: "bg-yellow-500"
  },
  {
    constant_type: constant_types[:imc],
    state: "Normal",
    description: "Peso saludable",
    min_value: 18.5,
    max_value: 24.9,
    priority: 2,
    color_class: "bg-green-500"
  },
  {
    constant_type: constant_types[:imc],
    state: "Sobrepeso",
    description: "Exceso de peso",
    min_value: 25.0,
    max_value: 29.9,
    priority: 3,
    color_class: "bg-yellow-500"
  },
  {
    constant_type: constant_types[:imc],
    state: "Obesidad I",
    description: "Obesidad grado I",
    min_value: 30.0,
    max_value: 34.9,
    priority: 4,
    color_class: "bg-orange-500"
  },
  {
    constant_type: constant_types[:imc],
    state: "Obesidad II",
    description: "Obesidad grado II",
    min_value: 35.0,
    max_value: 39.9,
    priority: 5,
    color_class: "bg-red-500"
  },
  {
    constant_type: constant_types[:imc],
    state: "Obesidad III",
    description: "Obesidad grado III - mórbida",
    min_value: 40.0,
    max_value: nil,
    priority: 6,
    color_class: "bg-red-600"
  }
])

puts "✅ Rangos creados: #{ConstantRange.count}"

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
# 📊 Constantes registradas (ESTADO SE CALCULA AUTOMÁTICAMENTE)
# ==========================================================

puts "📈 Creando mediciones (constants)..."

constants_data = [
  {
    patient: patients[0],
    constant_type: constant_types[:temperatura],
    value: 36.8,
    notes: "Normal, sin fiebre",
    date_time_taken: rand(30).days.ago
  },
  {
    patient: patients[0],
    constant_type: constant_types[:frecuencia_cardiaca],
    value: 72,
    notes: "Frecuencia cardíaca normal",
    date_time_taken: rand(30).days.ago
  },
  {
    patient: patients[0],
    constant_type: constant_types[:presion_arterial_sistolica],
    value: 118,
    notes: "Presión sistólica normal",
    date_time_taken: rand(30).days.ago
  },
  {
    patient: patients[0],
    constant_type: constant_types[:presion_arterial_diastolica],
    value: 78,
    notes: "Presión diastólica normal",
    date_time_taken: rand(30).days.ago
  },
  {
    patient: patients[1],
    constant_type: constant_types[:temperatura],
    value: 38.5,
    notes: "Fiebre moderada",
    date_time_taken: rand(30).days.ago
  },
  {
    patient: patients[1],
    constant_type: constant_types[:frecuencia_respiratoria],
    value: 22,
    notes: "Ligera taquipnea",
    date_time_taken: rand(30).days.ago
  },
  {
    patient: patients[2],
    constant_type: constant_types[:imc],
    value: 31.2,
    notes: "Obesidad grado I",
    date_time_taken: rand(30).days.ago
  },
  {
    patient: patients[2],
    constant_type: constant_types[:saturacion_oxigeno],
    value: 93,
    notes: "Leve hipoxemia",
    date_time_taken: rand(30).days.ago
  },
  {
    patient: patients[3],
    constant_type: constant_types[:frecuencia_cardiaca],
    value: 85,
    notes: "Ligera taquicardia",
    date_time_taken: rand(30).days.ago
  },
  {
    patient: patients[4],
    constant_type: constant_types[:imc],
    value: 22.5,
    notes: "Peso normal",
    date_time_taken: rand(30).days.ago
  }
]

# Crear constants y mostrar el estado calculado
constants_data.each do |data|
  constant = Constant.create!(data)
  puts "  ✅ #{constant.constant_type.name}: #{constant.value}#{constant.constant_type.unit} → #{constant.calculated_state}"
end

puts "✅ Constantes registradas: #{Constant.count}"

# ==========================================================
# ✅ Verificación final
# ==========================================================

puts "\n" + "="*50
puts "✅ VERIFICACIÓN FINAL"
puts "="*50
puts "📊 Total Unidades de Medida: #{UnitOfMeasurement.count}"
puts "🧠 Total Tipos de Constantes: #{ConstantType.count}"
puts "🎯 Total Rangos de Constantes: #{ConstantRange.count}"
puts "👥 Total Pacientes: #{Patient.count}"
puts "📈 Total Constantes: #{Constant.count}"

# Verificar que todas las constants tengan estado calculado
constants_sin_estado = Constant.where(calculated_state: nil)
if constants_sin_estado.any?
  puts "⚠️  Constants sin estado calculado: #{constants_sin_estado.count}"
  constants_sin_estado.each do |constant|
    puts "   - Constant ID: #{constant.id}, Type: #{constant.constant_type.name}, Value: #{constant.value}"
  end
else
  puts "🎉 ¡TODAS LAS CONSTANTS TIENEN ESTADO CALCULADO AUTOMÁTICAMENTE!"
end

puts "\n🎉 SEED COMPLETO: Base de datos lista para desarrollo."
