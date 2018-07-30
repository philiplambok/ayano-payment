require 'rails_helper'

RSpec.describe "user sign in", type: :request do
  let (:user) { create(:member) }

  it "return jwt token" do
    post '/api/auth', params: { auth: { username: user.username, password: user.password } }

    expect(response.body).to include("jwt", generate_token(user_id: user.id)) 
  end

  context "credential is wrong" do
    it "return 'Username or password is wrong' message" do 
      post '/api/auth', params: { auth: { username: "wrong username", password: "wrong password" } }

      expect(response.body).to include("error", "422", "Username or password is wrong")
    end
  end
end