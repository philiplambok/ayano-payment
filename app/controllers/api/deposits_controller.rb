class Api::DepositsController < ApplicationController
  before_action :set_user
  before_action :validate_avaiability
  before_action :validate_auth
  before_action :validate_permission
  before_action :validate_deposit

  def index 
    json_response(@user.deposit)
  end

  def create 
    case params[:type]
    when "save"
      @user.add_deposit({ amount: params[:amount], log: true})
    when "take"
      @user.take_deposit({ amount: params[:amount], log: true })
    end

    json_response(@user.deposit)
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
    error_response(template: :forbidden) unless current_user.same?(@user)
  end

  def validate_deposit 
    if params[:type] == "take"
      error_response(template: :deposit_not_enough) unless current_user.take_deposit?(params[:amount])
    end
  end
end
