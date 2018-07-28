require 'rails_helper'

RSpec.describe "Api::Roles", type: :request do
  describe "show role" do
    it "return role if role found" do 
      role = create(:role, name: "admin")
      get api_role_path(role)

      expect(json_parse(response.body)).to include(role_params(role))
    end

    it "return not found message if role not found" do 
      get "/api/roles/99" # => not found

      expect(response.body).to include("404", "Sorry, role not found")
    end
  end

  describe "show all roles" do 
    it "returns roles" do
      admin_role = create(:role, name: "admin")
      member_role = create(:role, name: "member")
      get api_roles_path 

      expect(response.body).to include(admin_role.id.to_s, admin_role.name, member_role.id.to_s, admin_role.name)      
    end
  end

  describe "create new role" do
    it "return created role" do
      role = build(:role, name: "admin")
      post api_roles_path, params: { role: { name: role.name } }

      expect(response.body).to include(role.name)
    end

    it "return name validation error" do 
      role = build(:role, name: nil)
      post api_roles_path, params: { role: { name: role.name } }

      expect(response.body).to include("422", "Name can't be blank")
    end
  end

  describe "update role" do 
    it "return updated role" do 
      role = create(:role, name: "member")
      updated_role_name = "premium"

      put api_role_path(role), params: { role: { name: updated_role_name } }

      expect(response.body).to include(role.id.to_s, updated_role_name)
    end

    it "return not found message if role not exist" do 
      updated_role_name = "premium"
      put "/api/roles/99", params: { role: { name: updated_role_name } }

      expect(response.body).to include("404", "Sorry, role not found")
    end

    it "return name validation" do 
      role = create(:role)

      put api_role_path(role), params: { role: { name: nil } }

      expect(response.body).to include("error", "422", "Name can't be blank")
    end
  end

  describe "delete role" do
    it "return deleted role" do 
      role = create(:role)

      delete api_role_path(role)

      expect(response.body).to include("#{role.id}", role.name)
    end

    it "return not found message if role not exists" do 
      delete "/api/roles/99"

      expect(response.body).to include("404", "Sorry, role not found")
    end
  end
end


def role_params(role)
  { "id" => role.id, "name" => role.name }
end