require 'rails_helper'

RSpec.describe "create new role" do
  let (:role) { build(:role) }

  context "as admin" do 
    let (:user) { create(:admin) }

    it "return created role" do
      post api_roles_path, params: role_params(role), headers: auth_params(user)

      expect(response.body).to include(role.name)
    end

    it "return name validation error" do 
      role.name = nil
      post api_roles_path, params: role_params(role), headers: auth_params(user)

      expect(response.body).to include("422", "Name can't be blank")
    end
  end

  context "as member" do 
    let (:user) { create(:member) }

    it "return forbidden message" do 
      post api_roles_path, params: role_params(role), headers: auth_params(user)

      expect_forbidden
    end
  end

  context "without auth" do 
    it "return not authenticated message" do 
      post api_roles_path, params: role_params(role)

      expect_not_authenticated
    end
  end
end
