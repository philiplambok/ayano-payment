class Api::RolesController < ApplicationController
  before_action :set_role, only: [:show]
  before_action :validate_avaiability, only: [:show]
  before_action :get_all_roles, only: [:index] 
    
  def index 
    json_response(@roles)
  end

  def show
    json_response(@role) 
  end

  private 
  def set_role 
    @role = Role.find_by_id(params[:id])
  end

  def validate_avaiability 
    error_response(code: 404, message: "Sorry, role not found") unless @role 
  end

  def get_all_roles 
    @roles = Role.all
  end
end
