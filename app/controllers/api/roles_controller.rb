class Api::RolesController < ApplicationController
  before_action :set_role, only: [:show, :update, :destroy]
  before_action :validate_avaiability, only: [:show, :update, :destroy]
  before_action :validate_auth
  before_action :validate_permission
  before_action :get_all_roles, only: [:index] 
    
  def index 
    json_response(@roles)
  end

  def show
    json_response(@role) 
  end

  def create
    @role = Role.new role_params

    if @role.save
      json_response(@role)
    else 
      error_response_name_blank(@role)
    end
  end

  def update
    if @role.update_attributes role_params 
      json_response(@role)
    else 
      error_response_name_blank(@role)
    end
  end

  def destroy 
    cache = @role
    if @role.destroy 
      json_response(cache)
    end
  end

  private 
  def set_role 
    @role = Role.find_by_id(params[:id])
  end

  def validate_auth 
    error_response(template: :unauthorized) unless current_user
  end

  def validate_avaiability 
    error_response(template: :not_found, model: "role") unless @role 
  end

  def validate_permission
    error_response(template: :forbidden) unless current_user.admin?
  end

  def get_all_roles 
    @roles = Role.all
  end

  def role_params 
    params.require(:role).permit(:name)
  end

  def error_response_name_blank(role)
    error_response(code: "422", message: "Name can't be blank") if role.errors[:name].include? "can't be blank" 
  end
end