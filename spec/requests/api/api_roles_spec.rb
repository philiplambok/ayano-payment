require 'rails_helper'

RSpec.describe "Api::Roles", type: :request do
  describe "show role" do
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

  describe "show all roles" do 
    let (:role_one) { create(:role, name: "role one") }
    let (:role_two) { create(:role, name: "role two") }

    before do 
      role_one.save 
      role_two.save
    end
    
    context "as admin" do
      let (:user) { create(:admin) }
      
      it "returns roles" do
        get api_roles_path, headers: auth_params(user)

        expect(response.body).to include(role_one.name, role_two.name)      
      end
    end

    context "as member" do
      let (:user) { create(:member) }

      it "is return forbidden message" do 
        get api_roles_path, headers: auth_params(user)

        expect_forbidden
      end
    end

    context "without auth" do
      it "return not authenticated message" do 
        get api_roles_path

        expect_not_authenticated
      end
    end
  end

  describe "create new role" do
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

  describe "update role" do 
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

  describe "delete role" do
    let (:role) { create(:role) }

    context "as admin" do
      let (:user) { create(:admin) }

      it "return deleted role" do 
        delete api_role_path(role), headers: auth_params(user)

        expect(response.body).to include(role.name)
      end
    end

    context "as member" do 
      let (:user) { create(:member) }

      it "return forbidden message" do 
        delete api_role_path(role), headers: auth_params(user)

        expect_forbidden
      end
    end

    context "without auth" do
      it "return not authenticated message" do 
        delete api_role_path(role)

        expect_not_authenticated
      end
    end

    context "role not found" do 
      let (:user) { create(:admin) }

      it "return not found message" do 
        delete "/api/roles/99", headers: auth_params(user)

        expect_not_found('role')
      end
    end
  end
end

def role_params(role)
  { role: { name: role.name } } 
end