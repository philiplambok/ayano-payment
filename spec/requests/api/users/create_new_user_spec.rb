require 'rails_helper'

RSpec.describe "create new user", type: :request do
  context "without auth" do 
    it "return created user" do
      user = build(:member)

      post api_users_path, params: user_params(user)

      expect(response.body).to include(user.username)
    end

    context "return errors" do 
      it "return username blank validation" do 
        user = build(:user, username: nil)

        post api_users_path, params: user_params(user)

        expect(response.body).to include("error", "422", "Username can't be blank")
      end 

      it "return password blank validation" do 
        user = build(:user, password: nil)

        post api_users_path, params: user_params(user)

        expect(response.body).to include("error", "422", "Password can't be blank")
      end
    end
  end 
end