require 'rails_helper'

RSpec.describe "delete user", type: :request do 
  let (:sample_user) { create(:sample_user) }

  context "as owner" do 
    it "return deleted user" do 
      delete api_user_path(sample_user), headers: auth_params(sample_user)

      expect(response.body).to include(sample_user.username)
    end
  end

  context "as admin" do 
    let (:user) { create(:admin) }

    it "return deleted user" do 
      delete api_user_path(sample_user), headers: auth_params(user)

      expect(response.body).to include(sample_user.username)
    end
  end

  context "as hacker" do 
    let (:user) { create(:hacker) }

    it "return forbidden message" do 
      delete api_user_path(sample_user), headers: auth_params(user)

      expect_forbidden
    end
  end

  context "without auth" do 
    it "return not authenticated message" do 
      delete api_user_path(sample_user)

      expect_not_authenticated
    end
  end

  context "user not found" do 
    it "return user found message" do
      delete "/api/users/99"

      expect(response.body).to include("error", "404", "Sorry, user not found")
    end
  end
end