class ApplicationController < ActionController::API
  def json_response(object)
    render json: object
  end

  def error_response(options)
    json_response(error:{code: options[:code], message: options[:message]})
  end
end
