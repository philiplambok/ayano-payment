require 'rails_helper'

RSpec.describe "show user", type: :request do
  let (:user) { create(:member) }

  context "as member" do 
    it "return user" do 
      get api_user_path(user), headers: auth_params(user)

      expect(response.body).to include("#{user.id}", user.username)
    end
  end

  context "without auth" do 
    it "return user" do 
      get api_user_path(user)

      expect(response.body).to include(user.username)
    end
  end

  context "user not exist" do 
    it "return not found message" do 
      get '/api/users/99'

      expect_not_found('user')
    end
  end
end