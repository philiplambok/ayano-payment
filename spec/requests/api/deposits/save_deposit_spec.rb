require 'rails_helper' 

RSpec.describe "save deposit" do 
  let (:sample_user) { create(:sample_user) }
  let (:amount) { "50000" }

  before do 
    sample_user.open_deposit!
  end

  context "as owner" do 
    it "return amount" do 
      request_post_deposit({ type: "save", amount: amount, user: sample_user, as_user: sample_user })
      
      expect(response.body).to include("amount", amount)
    end
  end

  context "as hacker" do 
    let (:hacker) { create(:hacker) }
    it "return forbidden message" do 
      request_post_deposit({type: "save", amount: amount, user: sample_user, as_user: hacker})

      expect_forbidden
    end
  end

  context "without auth" do 
    it "return not authenticated message" do 
      request_post_deposit({type: "save", amount: amount, user: sample_user, as_user: nil})

      expect_not_authenticated
    end
  end

  context "user didn't exist" do 
    it "return not found message" do 
      post "/api/users/99/deposits", params: { type: "save", amount: amount }, headers: auth_params(sample_user)

      expect_not_found('user')
    end
  end
end