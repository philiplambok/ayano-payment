module ParamsSupport 
  def user_params(user)
    { user: { username: user.username, password: user.password, password_confirmation: user.password_confirmation } }
  end

  def role_params(role)
    { role: { name: role.name } } 
  end
end

RSpec.configure do |config| 
  config.include ParamsSupport
end