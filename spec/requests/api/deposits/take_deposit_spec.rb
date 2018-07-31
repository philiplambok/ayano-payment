require 'rails_helper'

RSpec.describe "take deposit", type: :request do 
  let(:sample_user) { create(:sample_user) }

  before do 
    sample_user.open_deposit!
    sample_user.add_deposit({ amount: "500000" })
  end
 
  context "as owner" do 
    it "return amount" do 
      request_post_deposit({ type: "take", user: sample_user, amount: "100000", as_user: sample_user })

      expect(response.body).to include("amount","400000")
    end

    it "return not enough message" do
      request_post_deposit({ type: "take", amount: "600000", user: sample_user, as_user: sample_user })

      expect(response.body).to include("error", "Sorry, your deposit is not enough")
    end
  end

  context "as hacker" do 
    let (:hacker) { create(:hacker) }

    before do
      sample_user
    end

    it "return forbidden message" do 
      request_post_deposit({type: "take", amount: "500000", user: sample_user, as_user: hacker })

      expect_forbidden
    end
  end

  context "without auth" do 
    it "return not authenticated message" do
      request_post_deposit({type: "take", amount: "500000", user: sample_user})

      expect_not_authenticated
    end
  end

  context "user didn't exist" do 
    it "return not found message" do
      not_user = build(:hacker)
      post '/api/users/99/deposits'

      expect_not_found('user')
    end
  end
end