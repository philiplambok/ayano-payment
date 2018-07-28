class Api::AuthController < ApplicationController
  before_action :must_sign_in, only: [:show]

  def create 
    user = User.find_by_username params[:auth][:username]

    if user && user.authenticate(params[:auth][:password])
      json_response({ jwt: generate_token(user_id: user.id) })
    else 
      error_response(code: 422, message: "Username or password is wrong")
    end
  end

  def show
    json_response(current_user)
  end

  def must_sign_in 
    error_response(code: 401, message: "Sorry, you're not authenticated") unless current_user
  end
end


