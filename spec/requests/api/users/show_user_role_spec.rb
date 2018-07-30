require 'rails_helper'

RSpec.describe "show user role", type: :request do
  let(:sample_user) { create(:sample_user) }

  context "as admin" do 
    let (:user) { create(:admin) }

    it "return role member" do 
      get role_api_user_path(sample_user), headers: auth_params(user)

      expect(response.body).to include(sample_user.role.name)
    end
  end
  
  context "as owner" do 
    it "return role" do 
      get role_api_user_path(sample_user), headers: auth_params(sample_user)

      expect(response.body).to include(sample_user.role.name)
    end
  end

  context "as hacker" do 
    let(:user) { create(:hacker) }

    it "return forbidden message" do 
      get role_api_user_path(sample_user), headers: auth_params(user)

      expect_forbidden
    end
  end

  context "without auth" do 
    it "return not authenticated" do 
      get role_api_user_path(sample_user)

      expect_not_authenticated
    end
  end

  context "user not exist" do 
    it "not found message" do 
      get "/api/users/99/role" 

      expect(response.body).to include("error", "404", "Sorry, user not found")
    end
  end
end