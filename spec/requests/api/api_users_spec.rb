require 'rails_helper'

RSpec.describe "Api::Users", type: :request do
  describe "show user" do
    it "return user" do 
      user = create(:user)
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
end
