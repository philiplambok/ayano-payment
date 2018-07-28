class Api::UsersController < ApplicationController
  before_action :set_user, only: [:show, :role] 
  before_action :validation_avaiability_user, only: [:show, :role]

  def show
    json_response(@user)
  end

  def create
    @user = User.new(params.require(:user).permit(:username, :password, :password_confirmation))

    if @user.save 
      json_response(@user)
    else 
      error_response_username_blank
      error_response_password_blank
    end
  end


  def role 
    json_response(@user.role)
  end

  private 
  def set_user 
    @user = User.find_by_id(params[:id])
  end

  def validation_avaiability_user 
    error_response(code: 404, message: "Sorry, user not found") unless @user
  end

  def error_response_username_blank
    error_response(code: 422, message: "Username can't be blank") if @user.errors[:username].include?("can't be blank") 
  end

  def error_response_password_blank 
    error_response(code: 422, message: "Password can't be blank") if @user.errors[:password].include?("can't be blank") 
  end
end
