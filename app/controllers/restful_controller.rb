# ================================================
# CONTROLLER->RESTFUL ============================
# ================================================
class RestfulController < ApplicationController
  include ApplicationHelper

  # ----------------------------------------------
  # FILTERS --------------------------------------
  # ----------------------------------------------
  # before_filter :filter_accessible, :only => [:create, :update]
  # before_filter :load_model,        :only => [:show, :update, :destroy]

  # ----------------------------------------------
  # CLASS-VARIABLES ------------------------------
  # ----------------------------------------------
  # FIX: Nullify these
  @@params_name = :song
  @@model_class = Song

  # ----------------------------------------------
  # RESPOND --------------------------------------
  # ----------------------------------------------
  # Since this is a JSON API, all of these actions will be responding to .json.
  respond_to :json

  # ----------------------------------------------
  # UPDATE ---------------------------------------
  # ----------------------------------------------
  def update
    @model = @@model_class.update params[:id], params[@@params_name]
    respond_with @model
  end

  # ----------------------------------------------
  # CREATE ---------------------------------------
  # ----------------------------------------------
  def create

    # Instantiate a new model from the params
    @model = @@model_class.new params[@@params_name]

    # FIX: Remove this from this controller
    @model.user = current_user if @model.respond_to?(:user=)

    if @model.save
      respond_with @model
    else
      respond_with @model.errors
    end
  end
  
  # ----------------------------------------------
  # SHOW -----------------------------------------
  # ----------------------------------------------
  def show
    respond_with @model
  end

  # ----------------------------------------------
  # DESTROY --------------------------------------
  # ----------------------------------------------
  def destroy
    respond_with @model = @model.destroy
  end

  # ----------------------------------------------
  # PRIVATE --------------------------------------
  # ----------------------------------------------
  private
  
  # ----------------------------------------------
  # PRIVATE->FILTERS -----------------------------
  # ----------------------------------------------
  def filter_accessible

    # Ensure params
    unless params[@@params_name]
      return render_error("ParameterException", "No attributes parameter supplied.")
    end

    # Ensure params[:...] has keys
    if params[@@params_name].empty?
      return render_error("ParameterException", "Attributes parameter is empty.")
    end

    params[@@params_name].each do |key, value|
      # Unless this model has this attribute as an accessible attribute, remove
      # it from params.
      unless @@model_class.accessible_attributes.to_a.map(&:to_sym).include?(key.to_sym)
        params[@@params_name].delete(key)
      end
    end
  end

  def load_model

    id = params[:id]

    # Ensure ID
    return render_error("ParameterException", "No ID supplied.") unless id

    begin
      @model = @@model_class.find params[:id]
    rescue Exception => exception
      return render_error("ModelException", "No #{@@model_class.to_s} with ID=#{id} found")
    end

  end
  
  # ----------------------------------------------
  # PRIVATE->ERROR-HANDLING ----------------------
  # ----------------------------------------------
  def render_error(type, message)
    render :json => {:type => type, :message => message}
  end
  
end
