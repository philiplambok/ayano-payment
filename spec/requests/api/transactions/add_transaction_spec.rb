require 'rails_helper'

RSpec.describe "add transaction", type: :request do
  let(:sample_user) { create(:sample_user) }
  let(:target_user) { create(:member, username: "target_user") }

  before do 
    sample_user.open_deposit! 
    target_user.open_deposit! 

    sample_user.add_deposit("100000")
  end

  context "as owner" do
    it "return amount" do 
      request_trasaction({ user: sample_user, to: target_user, amount: 50000, as: sample_user })

      expect(response.body).to include("amount","50000")

      expect_deposit({user: sample_user, as_user: sample_user, amount: 50000})
    end

    it "return deposit not enough" do 
      request_trasaction({ user: sample_user, to: target_user, amount: 500000, as: sample_user })
      
      expect(response.body).to include("error", "422", "Sorry, your deposit is not enough")
    end
  end

  context "as hacker" do 
    let (:user) { create(:hacker) }

    it "return forbidden message" do 
      request_trasaction({ user: sample_user, to: target_user, amount: 50000, as: user })
      
      expect_forbidden
    end
  end

  context "without auth" do 
    it "return not authenticated message" do
      request_trasaction(user: sample_user, to: target_user, amount: 50000)

      expect_not_authenticated
    end
  end
end

def expect_deposit(options)
  get deposits_api_user_path(options[:user]), headers: auth_params(options[:as_user])

  expect(response.body).to include("amount", "#{options[:amount]}")
end

def request_trasaction(options)
  auth = auth_params(options[:as]) if options[:as] 

  post transaction_api_user_path(options[:user]), params: { to: options[:to].id , amount: options[:amount] }, headers: auth
end