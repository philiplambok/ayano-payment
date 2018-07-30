class ApplicationController < ActionController::API
  def json_response(object)
    render json: object
  end

  def error_response(options)
    json_response(error:{ code: options[:code], message: options[:message] }) unless options[:template]

    case options[:template]
    when :unauthorized 
      error_response(code: 401, message: "Sorry, you're not authenticated")
    when :forbidden
      error_response(code: 403, message: "Sorry, you haven't permission")
    when :not_found
      error_response(code: 404, message: "Sorry, #{options[:model]} not found")
    end
  end

  def generate_token(payload)
    JWT.encode payload, nil, 'none' 
  end

  def decode_token(token)
    begin
      JWT.decode token, nil, false
    rescue
      nil
    end
  end

  def current_user 
    # set token 
    return nil unless request.headers[:authorization]

    authorization_header = request.headers[:authorization].split(" ")

    return nil unless authorization_header.count == 2
    return nil unless authorization_header.first == "Bearer"

    # decode token 
    decoded_token = decode_token(authorization_header.last)
    return nil unless decoded_token
    
    user_id = decoded_token[0]["user_id"] 

    # set user
    User.find_by_id user_id
  end
end
