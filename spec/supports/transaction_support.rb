module TransactionSupport 
  def expect_deposit(options)
    get deposits_api_user_path(options[:user]), headers: auth_params(options[:as_user])

    expect(response.body).to include("amount", "#{options[:amount]}")
  end

  def request_transaction(options)
    auth = auth_params(options[:as]) if options[:as] 

    post transaction_api_user_path(options[:user]), params: { to: options[:to].id , amount: options[:amount] }, headers: auth
  end
end

RSpec.configure do |config|
  config.include TransactionSupport
end