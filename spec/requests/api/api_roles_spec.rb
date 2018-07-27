require 'rails_helper'

RSpec.describe "Api::Roles", type: :request do
  describe "/api/roles/:id" do
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

  describe "/api/roles" do 
    it "returns roles" do
      admin_role = create(:role, name: "admin")
      member_role = create(:role, name: "member")
      get api_roles_path 
      
      expect(response.body).to include(admin_role.id.to_s, admin_role.name, member_role.id.to_s, admin_role.name)      
    end
  end
end


def role_params(role)
  { "id" => role.id, "name" => role.name }
end