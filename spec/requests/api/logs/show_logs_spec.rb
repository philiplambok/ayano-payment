require 'rails_helper'

RSpec.describe "show logs", type: :request do 
  let (:target_user) { create(:member, username: "target_user") }
  let (:user) { create(:member) }

  before do 
    user.open_deposit!
  end

  describe "take deposit" do
    before do 
      user.add_deposit({ amount: "100000" })
    end

    context "as owner" do
      it "return take deposit log message" do 
        request_post_deposit(as_user: user, user: user, type: "take", amount: "50000")
        expect(response.body).to include("amount", "50000")

        get logs_api_user_path(user), headers: auth_params(user)
        expect(response.body).to include("message", "You take deposit 50000")
      end
    end
  end

  describe "save deposit" do 
    context "as owner" do 
      it "return added deposit message" do 
        request_post_deposit(as_user: user, user: user, type: "save", amount: "50000")
        expect(response.body).to include("amount", "50000")

        get logs_api_user_path(user), headers: auth_params(user)
        expect(response.body).to include("message", "You added deposit 50000")
      end
    end
  end

  describe "transfer" do 
    before do 
      target_user.open_deposit!
      user.add_deposit({ amount: "100000" })
    end

    context "as owner" do 
      it "return send deposit messsage" do 
        request_transaction({ user: user, to: target_user, amount: "20000", as: user })

        get logs_api_user_path(user), headers: auth_params(user)

        expect(response.body).to include("message", "You send 20000 to #{target_user.username}")
      end
    end
  end
end