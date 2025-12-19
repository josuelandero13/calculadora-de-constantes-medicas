class ConstantsController < ApplicationController
  before_action :set_constant, only: %i[edit update destroy]
  before_action :set_collections, only: %i[index]

  def index
    @constants = FindConstants.new.call(params)
    preload_state_colors
  end

  def show
    constant = Constant.includes(:patient, :constant_type, :unit_of_measurement)
                       .find(params[:id])

    @described_reading = ConstantPresenter.new(constant)
  end

  def new
    @constant = Constant.new

    respond_to do |format|
      format.turbo_stream { render_constant_form(@constant) }
      format.html
    end
  end

  def create
    @constant = Constant.new(constant_params)

    respond_to do |format|
      if @constant.save
        format.turbo_stream
        format.html { redirect_to constants_path, notice: "Toma creada exitosamente" }
      else
        format.turbo_stream { render_constant_form(@constant) }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    if @constant.update(constant_params)
      redirect_to root_path, notice: "Toma actualizada exitosamente"
    else
      render :edit
    end
  end

  def destroy
    @constant.destroy

    redirect_to root_path, notice: "Toma eliminada correctamente"
  end

  private

  def render_constant_form(constant)
    render turbo_stream: turbo_stream.replace(
      "constant_form",
      partial: "constants/form_modal",
      locals: { constant: constant }
    )
  end

  def set_constant
    @constant = Constant.find(params[:id])
  end

  def set_collections
    @patients = Patient.all
    @constant_types = ConstantType.with_constants_count
  end

  def constant_params
    params.require(:constant)
          .permit(
            :patient_id, :constant_type_id, :value,
            :notes, :date_time_taken, :date, :time
          )
  end

  def preload_state_colors
    states = @constants.map(&:calculated_state).compact.map(&:downcase).uniq

    return @state_colors = {} if states.empty?

    @state_colors = ConstantRange.where("LOWER(state) IN (?)", states)
                                 .pluck(Arel.sql("LOWER(state)"), :color_class)
                                 .to_h
  end
end
