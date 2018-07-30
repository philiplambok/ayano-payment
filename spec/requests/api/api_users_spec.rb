require 'rails_helper'

RSpec.describe "Api::Users", type: :request do
  describe "show user" do
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

  describe "show user role" do
    let(:sample_user) { create(:sample_user) }

    context "as admin" do 
      let (:user) { create(:admin) }

      it "return role member" do 
        get role_api_user_path(sample_user), headers: auth_params(user)

        expect(response.body).to include(sample_user.role.name)
      end
    end
    
    context "as owner" do 
      it "return role" do 
        get role_api_user_path(sample_user), headers: auth_params(sample_user)

        expect(response.body).to include(sample_user.role.name)
      end
    end

    context "as hacker" do 
      let(:user) { create(:hacker) }

      it "return forbidden message" do 
        get role_api_user_path(sample_user), headers: auth_params(user)

        expect_forbidden
      end
    end

    context "without auth" do 
      it "return not authenticated" do 
        get role_api_user_path(sample_user)

        expect_not_authenticated
      end
    end

    context "user not exist" do 
      it "not found message" do 
        get "/api/users/99/role" 

        expect(response.body).to include("error", "404", "Sorry, user not found")
      end
    end
  end

  describe "create new user" do
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

  describe "update user" do 
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

  describe "delete user" do 
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

  describe "show current user" do
    let(:user) { create(:member) }

    context "with auth" do 
      it "return current user" do 
        get "/api/me", params: nil, headers: auth_params(user)

        expect(response.body).to include(user.username)
      end
    end

    context "without auth" do 
      context "no headers" do
        it "return not authenticated message" do 
          get "/api/me"

          expect_not_authenticated
        end
      end

      context "unexpected format" do
        it "return not authenticated message" do 
          get "/api/me", params: nil, headers: { authorization: "Bearer 2 3" }

          expect_not_authenticated
        end
      end

      context "not include Bearer text" do 
        it "return not authenticated message" do 
          get "/api/me", params: nil, headers: { authorization: "non non non" }

          expect_not_authenticated
        end
      end

      context "bad token" do 
        it "return not authenticated message" do
          get "/api/me", params: nil, headers: { authorization: "Bearer bad_token_here" }

          expect_not_authenticated
        end
      end
    end
  end
end

def user_params(user)
  { user: { username: user.username, password: user.password, password_confirmation: user.password_confirmation } }
end