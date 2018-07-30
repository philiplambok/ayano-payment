require 'rails_helper'

RSpec.describe "show current user", type: :request do
  let(:user) { create(:member) }

  context "with auth" do 
    it "return current user" do 
      get "/api/me", params: nil, headers: auth_params(user)

      expect(response.body).to include(user.username)
    end
  end

  context "without auth" do 
    context "no headers" do
      it "return not authenticated message" do 
        get "/api/me"

        expect_not_authenticated
      end
    end

    context "unexpected format" do
      it "return not authenticated message" do 
        get "/api/me", params: nil, headers: { authorization: "Bearer 2 3" }

        expect_not_authenticated
      end
    end

    context "not include Bearer text" do 
      it "return not authenticated message" do 
        get "/api/me", params: nil, headers: { authorization: "non non non" }

        expect_not_authenticated
      end
    end

    context "bad token" do 
      it "return not authenticated message" do
        get "/api/me", params: nil, headers: { authorization: "Bearer bad_token_here" }

        expect_not_authenticated
      end
    end
  end
end