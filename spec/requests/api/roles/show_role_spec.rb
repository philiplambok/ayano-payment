require 'rails_helper'

RSpec.describe "show role", type: :request do
  let (:role) { create(:role) }

  context "as admin" do 
    let (:user) { create(:admin) }
    
    it "return role" do 
      get api_role_path(role), headers: auth_params(user)

      expect(response.body).to include(role.name)
    end
  end

  context "as member" do 
    let(:user) { create(:member) }

    it "return forbidden message" do 
      get api_role_path(role), headers: auth_params(user)

      expect_forbidden
    end
  end

  context "without auth" do 
    it "return not authenticated message" do 
      get api_role_path(role)

      expect_not_authenticated
    end
  end

  context "role not found" do 
    it "return not found message" do 
      get "/api/roles/99" # => not found

      expect_not_found("role")
    end
  end 
end
