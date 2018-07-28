class Api::UsersController < ApplicationController
  before_action :set_user, only: [:show] 
  before_action :validation_avaiability_user, only: [:show]

  def show
    json_response(@user)
  end

  private 
  def set_user 
    @user = User.find_by_id(params[:id])
  end

  def validation_avaiability_user 
    error_response(code: 404, message: "Sorry, user not found") unless @user
  end
end
