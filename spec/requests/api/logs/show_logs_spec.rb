require 'rails_helper'

RSpec.describe "show logs", type: :request do 
  let (:target_user) { create(:member, username: "target_user") }
  let (:user) { create(:member) }

  before do 
    user.open_deposit!
  end

  context "as owner" do 
    before do 
      user.add_deposit({ amount: "100000" })
    end

    describe "take deposit" do
      it "return take deposit log message" do 
        request_post_deposit(as_user: user, user: user, type: "take", amount: "50000")
        expect(response.body).to include("amount", "50000")

        get logs_api_user_path(user), headers: auth_params(user)
        expect(response.body).to include("message", "You take deposit 50000")
      end
    end

    describe "save deposit" do 
      it "return added deposit message" do 
        request_post_deposit(as_user: user, user: user, type: "save", amount: "50000")
        expect(response.body).to include("amount", "50000")

        get logs_api_user_path(user), headers: auth_params(user)
        expect(response.body).to include("message", "You added deposit 50000")
      end
    end

    describe "transfer" do 
      before do 
        target_user.open_deposit!
        user.add_deposit({ amount: "100000" })
      end

      it "return send deposit messsage" do 
        request_transaction({ user: user, to: target_user, amount: "20000", as: user })

        get logs_api_user_path(user), headers: auth_params(user)

        expect(response.body).to include("message", "You send 20000 to #{target_user.username}")
      end
    end
  end

  context "as hacker" do 
    let (:hacker) { create(:hacker) }
    it "return forbidden message" do 
      get logs_api_user_path(user), headers: auth_params(hacker)

      expect_forbidden
    end
  end

  context "without auth" do 
    it 'return not authenticated message' do
      get logs_api_user_path(user), headers: nil

      expect_not_authenticated
    end
  end

  context "user didn't exist" do
    it "return not found message" do 
      get '/api/users/99/logs', headers: auth_params(user)

      expect_not_found('user')
    end 
  end
end