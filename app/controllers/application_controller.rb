class ApplicationController < ActionController::API
  def json_response(object)
    render json: object
  end

  def error_response(options)
    json_response(error:{code: options[:code], message: options[:message]})
  end

  def generate_token(payload)
    JWT.encode payload, nil, 'none' 
  end

  def decode_token(token)
    JWT.decode token, nil, false
  end

  def current_user 
    # set token 
    return nil unless request.headers[:authorization]
    token = request.headers[:authorization].split(" ").last

    # decode token 
    decoded_token = decode_token(token)
    user_id = decoded_token[0]["user_id"] 

    # set user
    User.find_by_id user_id
  end
end
