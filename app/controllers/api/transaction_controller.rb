class Api::TransactionController < ApplicationController
  before_action :set_user
  before_action :set_target_user
  before_action :validate_deposit
  before_action :validate_auth
  before_action :validate_permission

  def create
    @user.transfer(to: @target_user, amount: params[:amount])
    json_response(@user.deposit)
  end

  private 
  def set_user 
    @user = User.find_by_id(params[:id])
  end

  def set_target_user 
    @target_user = User.find_by_id(params[:to])
  end

  def validate_deposit 
    error_response(template: :deposit_not_enough) unless @user.take_deposit?(params[:amount])
  end

  def validate_auth 
    error_response(template: :unauthorized) unless current_user
  end

  def validate_permission 
    error_response(template: :forbidden) unless current_user.owner_or_admin?(@user)
  end
end
