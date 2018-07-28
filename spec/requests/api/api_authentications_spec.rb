require 'rails_helper'

RSpec.describe "Api::Authentications", type: :request do
  describe "user sign in" do
    
    let (:user) { create(:user, role: create(:role)) }

    it "return jwt token" do
      post '/api/auth', params: { auth: { username: user.username, password: user.password } }

      expect(response.body).to include("jwt", generate_token(user.id)) 
    end

    context "credential is wrong" do
      it "return 'Username or password is wrong' message" do 
        post '/api/auth', params: { auth: { username: "wrong username", password: "wrong password" } }

        expect(response.body).to include("error", "422", "Username or password is wrong")
      end
    end
  end
end

def generate_token(user_id)
  payload = { user_id: user_id }
  JWT.encode payload, nil, 'none'
end