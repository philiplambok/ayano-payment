require 'rails_helper'

RSpec.describe "Show Deposit", type: :request do
  let (:sample_user) { create(:sample_user) }

  before do 
    sample_user.open_deposit!
  end

  context "as owner user" do 
    it "return deposit" do
      get deposits_api_user_path(sample_user), headers: auth_params(sample_user)

      expect(response.body).to include("amount", "0")
    end
  end

  context "as hacker" do 
    let (:hacker) { create(:hacker) }

    it "return forbidden message" do 
      get deposits_api_user_path(sample_user), headers: auth_params(hacker)

      expect_forbidden
    end
  end

  context "without auth" do 
    it "return not authenticated message" do 
      get deposits_api_user_path(sample_user)

      expect_not_authenticated
    end
  end

  context "user didn't exist" do 
    it "return not found message" do 
      get "/api/users/99/deposits", headers: auth_params(sample_user)

      expect_not_found('user')
    end
  end
end