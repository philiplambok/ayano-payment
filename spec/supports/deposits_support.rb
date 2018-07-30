module DepositsSupport 
  def request_post_deposit(options)
    auth = auth_params(options[:as_user]) if options[:as_user]

    post deposits_api_user_path(options[:user]), params: { type: options[:type], amount:  options[:amount] }, headers: auth
  end
end

RSpec.configure do |config| 
  config.include DepositsSupport
end