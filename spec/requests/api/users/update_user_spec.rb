require 'rails_helper'

RSpec.describe "update user", type: :request do 
  let (:sample_user) { create(:sample_user) }
  let(:updated_username) { "pquest_updated" }

  context "as owner" do 

    it "return updated user" do 
      sample_user.username = updated_username
      put api_user_path(sample_user), params: user_params(sample_user), headers: auth_params(sample_user)

      expect(response.body).to include(updated_username) 
    end

    it "validation error: return username can't be blank" do
      sample_user.username = nil
      put api_user_path(sample_user), params: user_params(sample_user), headers: auth_params(sample_user)

      expect(response.body).to include("error", "422", "Username can't be blank")
    end
  end

  context "as admin" do 
    let (:user) { create(:admin) }

    it "return updated user" do 
      sample_user.username = updated_username
      put api_user_path(sample_user), params: user_params(sample_user), headers: auth_params(user)

      expect(response.body).to include(updated_username)
    end
  end

  context "as hacker" do 
    let (:user) { create(:hacker) }

    it "return forbidden message" do 
      sample_user.username = updated_username
      put api_user_path(sample_user), params: user_params(sample_user), headers: auth_params(user)

      expect_forbidden
    end
  end

  context "without auth" do 
    it "return not authenticated message" do 
      sample_user.username = updated_username
      put api_user_path(sample_user), params: user_params(sample_user)

      expect_not_authenticated
    end
  end

  context "user not found" do 
    it "return not found message" do 
      put "/api/users/99", params: user_params(sample_user)

      expect(response.body).to include("error", "404", "Sorry, user not found")
    end
  end
end