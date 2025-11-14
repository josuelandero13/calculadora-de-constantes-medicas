
module ConstantsHelper
  def constant_state_display(constant)
    state = constant&.calculated_state
    display_text = state&.upcase || "SIN ESTADO"

    circle_color = state_color_for(state) || "bg-gray-400"

    { color: circle_color, text: display_text }
  end

  def constant_type_icon(constant_type_name)
    icon_mapping = {
      "temperatura corporal" => "🌡️",
      "temperatura" => "🌡️",
      "frecuencia cardiaca" => "❤️",
      "frecuencia cardíaca" => "❤️",
      "pulso" => "❤️",
      "frecuencia respiratoria" => "🫁",
      "respiración" => "🫁",
      "presión arterial sistólica" => "💓",
      "presión arterial diastólica" => "💓",
      "presión arterial" => "💓",
      "saturación de oxígeno (spo₂)" => "🩸",
      "saturación de oxígeno" => "🩸",
      "índice de masa corporal (imc)" => "⚖️",
      "imc" => "⚖️",
      "glucosa" => "🩺",
      "azúcar en sangre" => "🩺",
      "peso" => "⚖️",
      "altura" => "📏",
      "estatura" => "📏"
    }

    icon_mapping[constant_type_name&.downcase] || "📊"
  end

  private

  def state_color_for(state)
    return nil unless state.present?

    Rails.cache.fetch("state_color_#{state.downcase}", expires_in: 1.hour) do
      ConstantRange.find_by("LOWER(state) = ?", state.downcase)&.color_class
    end
  end
end
