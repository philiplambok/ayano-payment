class Api::AuthController < ApplicationController
  def create 
    user = User.find_by_username params[:auth][:username]

    if user && user.authenticate(params[:auth][:password])
      json_response({ jwt: generate_token(user.id) })
    else 
      error_response(code: 422, message: "Username or password is wrong")
    end
  end
end

private

def generate_token(user_id)
  payload = { user_id: user_id }
  JWT.encode payload, nil, 'none'
end

