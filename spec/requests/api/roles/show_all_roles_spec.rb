require 'rails_helper'

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