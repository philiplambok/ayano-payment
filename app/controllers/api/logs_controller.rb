class Api::LogsController < ApplicationController
  before_action :set_user 
  before_action :validate_avaiability
  before_action :validate_auth
  before_action :validate_permission

  def index
    json_response(@user.logs)
  end

  private 
  def set_user
    @user = User.find_by_id(params[:id])
  end

  def validate_avaiability
    error_response(template: :not_found, model: "user") unless @user 
  end

  def validate_auth 
    error_response(template: :unauthorized) unless current_user
  end

  def validate_permission
    error_response(template: :forbidden) unless current_user.owner_or_admin?(@user)
  end
end
