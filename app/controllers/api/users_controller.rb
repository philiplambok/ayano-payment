class Api::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :role, :destroy] 
  before_action :validate_avaiability_user, only: [:show, :update, :role, :destroy]
  before_action :validate_auth, only: [:role, :update, :destroy]
  before_action :validate_permission, only: [:role, :update, :destroy]

  def show
    json_response(@user)
  end

  def create
    @user = User.new(user_params)

    if @user.save 
      json_response(@user)
    else
      error_response_username_blank
      error_response_password_blank
    end
  end

  def update
    if @user.update_attributes(user_params)
      json_response(@user)
    else 
      error_response_username_blank
    end
  end

  def destroy
    cache = @user 
    if @user.delete
      json_response(cache)
    end
  end

  def role 
    json_response(@user.role)
  end

  private 
  def set_user
    @user = User.find_by_id(params[:id])
  end

  def user_params 
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

  def validate_avaiability_user 
    error_response(template: :not_found, model: "user") unless @user
  end

  def validate_auth
    error_response(template: :unauthorized) unless current_user
  end

  def validate_permission 
    error_response(template: :forbidden) unless current_user.owner_or_admin?(@user)
  end

  def error_response_username_blank
    error_response(code: 422, message: "Username can't be blank") if @user.errors[:username].include?("can't be blank") 
  end

  def error_response_password_blank 
    error_response(code: 422, message: "Password can't be blank") if @user.errors[:password].include?("can't be blank") 
  end
end
