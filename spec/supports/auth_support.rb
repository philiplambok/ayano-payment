module AuthSupport 
  def auth_params(user)
    token = generate_token(user_id: user.id)

    { authorization: "Bearer #{token}" }
  end

  def expect_not_authenticated 
    expect(response.body).to include("error", "401", "Sorry, you're not authenticated") 
  end

  def generate_token(payload)
    JWT.encode payload, nil, 'none'
  end
end

RSpec.configure do |config| 
  config.include AuthSupport
end