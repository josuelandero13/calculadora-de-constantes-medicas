
module ConstantsHelper
  SORTING_ICON = <<~SVG.freeze
    <svg class="w-4 h-4 opacity-0 group-hover:opacity-100 transition-opacity duration-200" fill="none" stroke="currentColor" viewBox="0 0 24 24">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16V4m0 0L3 8m4-4l4 4m6 0v12m0 0l4-4m-4 4l-4-4"></path>
    </svg>
  SVG

  ACTION_ICONS = {
    eye: <<~SVG.freeze,
      <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
        <path d="M10 12a2 2 0 100-4 2 2 0 000 4z" />
        <path fill-rule="evenodd" d="M.458 10C1.732 5.943 5.522 3 10 3s8.268 2.943 9.542 7c-1.274 4.057-5.064 7-9.542 7S1.732 14.057.458 10zM14 10a4 4 0 11-8 0 4 4 0 018 0z" clip-rule="evenodd" />
      </svg>
    SVG
    pencil: <<~SVG.freeze,
      <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
        <path d="M13.586 3.586a2 2 0 112.828 2.828l-.793.793-2.828-2.828.793-.793zM11.379 5.793L3 14.172V17h2.828l8.38-8.379-2.83-2.828z" />
      </svg>
    SVG
    trash: <<~SVG.freeze
      <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
        <path fill-rule="evenodd" d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z" clip-rule="evenodd" />
      </svg>
    SVG
  }.freeze

  def constants_table_headers
    [
      { label: "PACIENTE" },
      { label: "TIPO" },
      { label: "VALOR" },
      { label: "FECHA" },
      { label: "ESTADO" },
      { label: "ACCIONES", sortable: false, align: :right }
    ]
  end

  def constants_table_header_cell(header)
    sortable = header.fetch(:sortable, true)
    align = header.fetch(:align, :left)

    classes = [
      "px-8 py-4 text-sm font-semibold text-white uppercase tracking-wider",
      align == :right ? "text-right" : "text-left"
    ]
    classes << "group cursor-pointer hover:bg-blue-600 transition-colors duration-200" if sortable

    content = tag.div(class: header_content_classes(align)) do
      safe_join([
        tag.span(header[:label]),
        (sortable ? sorting_icon : nil)
      ].compact)
    end

    tag.th(content, scope: "col", class: classes.join(" "))
  end

  def constant_state_display(constant, state_colors)
    state = constant&.calculated_state
    normalized_state = state&.downcase

    {
      text: state&.upcase || "SIN ESTADO",
      color: state_colors[normalized_state] || "bg-gray-400"
    }
  end

  def constant_state_badge(constant, state_colors)
    state_display = constant_state_display(constant, state_colors)

    tag.div class: "flex items-center space-x-2" do
      safe_join([
        tag.span("", class: "h-3 w-3 rounded-full #{state_display[:color]}"),
        tag.span(state_display[:text], class: "text-sm text-gray-700")
      ])
    end
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

  def constant_action_buttons(constant)
    safe_join(
      [
        action_link(constant_path(constant), :eye, "text-[#007bfe] hover:text-[#0069d9] transition-colors duration-200 p-1 rounded-full hover:bg-blue-50", "Ver"),
        action_link(edit_constant_path(constant), :pencil, "text-yellow-600 hover:text-yellow-800 transition-colors duration-200 p-1 rounded-full hover:bg-yellow-50", "Editar"),
        action_button(constant_path(constant), :trash, "text-red-600 hover:text-red-800 transition-colors duration-200 p-1 rounded-full hover:bg-red-50", "Eliminar")
      ],
      "\n"
    )
  end

  private

  def sorting_icon
    @sorting_icon ||= SORTING_ICON.html_safe
  end

  def header_content_classes(align)
    classes = [ "flex items-center space-x-2" ]
    classes << "justify-end" if align == :right
    classes.join(" ")
  end

  def action_link(path, icon_key, classes, title)
    link_to(path, class: classes, title: title) do
      constant_icon(icon_key)
    end
  end

  def action_button(path, icon_key, classes, title)
    button_to(path,
              method: :delete,
              form: { class: "inline" },
              data: { turbo_confirm: "¿Estás seguro de eliminar este registro?" },
              class: classes,
              title: title) do
      constant_icon(icon_key)
    end
  end

  def constant_icon(key)
    ACTION_ICONS[key].html_safe
  end

  def format_measured_at(measured_at)
    return unless measured_at

    time = measured_at.is_a?(String) ? Time.zone.parse(measured_at) : measured_at
    time&.strftime("%d/%m/%Y %I:%M %p")
  end
end
