module JWTSupport 
  def generate_token(payload)
    JWT.encode payload, nil, 'none'
  end
end

RSpec.configure do |config| 
  config.include JWTSupport
end