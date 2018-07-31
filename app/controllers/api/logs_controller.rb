class Api::LogsController < ApplicationController
  before_action :set_user 

  def index
    json_response(@user.logs)
  end

  private 
  def set_user 
    @user = User.find_by_id(params[:id])
  end
end
