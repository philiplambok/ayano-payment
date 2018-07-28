require 'rails_helper'

RSpec.describe "Api::Users", type: :request do
  describe "show user" do
    it "return user" do 
      role = create(:role)
      user = create(:user, role: role)
      get api_user_path(user)

      expect(response.body).to include("#{user.id}", user.username)
    end

    context "user not exists" do 
      it "return not found message" do 
        get '/api/users/99'

        expect(response.body).to include("error", "404", "Sorry, user not found")
      end
    end
  end

  describe "create new user" do 
    it "return created user" do 
      user = build(:user) 

      post api_users_path, params: user_params(user)

      expect(response.body).to include(user.username)
    end

    context "return errors" do 
      it "return name username validation" do 
        user = build(:user, username: nil)

        post api_users_path, params: user_params(user)

        expect(response.body).to include("error", "422", "Username can't be blank")
      end 
    end
  end
end

def user_params(user)
  { user: { username: user.username, password: user.password, password_confirmation: user.password_confirmation } }
end