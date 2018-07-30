require 'rails_helper'

RSpec.describe "update role", type: :request do 
  let (:role) { create(:role) }
  let (:updated_role_name) { "premium" }

  context "as admin" do
    let (:user) { create(:admin) }

    it "return updated role" do
      role.name = updated_role_name
      put api_role_path(role), params: role_params(role), headers: auth_params(user)

      expect(response.body).to include(role.id.to_s, updated_role_name)
    end

    it "return name validation" do 
      role.name = nil
      put api_role_path(role), params: role_params(role), headers: auth_params(user)

      expect(response.body).to include("error", "422", "Name can't be blank")
    end
  end

  context "as member" do
    let (:user) { create(:member) }

    it "return forbidden message" do 
      role.name = updated_role_name
      put api_role_path(role), params: role_params(role), headers: auth_params(user)

      expect_forbidden
    end
  end

  context "without auth" do 
    it "return not authenticated message" do 
      role.name = updated_role_name
      put api_role_path(role), params: role_params(role) 

      expect_not_authenticated
    end
  end

  context "role not found" do
    let (:user) { create(:admin) }

    it "return not found message if role not exist" do 
      put "/api/roles/99", params: role_params(role), headers: auth_params(user)

      expect_not_found('role')
    end
  end
end