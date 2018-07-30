require 'rails_helper'

RSpec.describe User, type: :model do
  it "valid with username" do 
    user = build(:user)
    user.valid? 

    expect(user.errors.full_messages).to be_empty
  end

  it "invalid without username" do 
    user = build(:user, username: nil)
    user.valid? 

    expect(user.errors.full_messages).to include("Username can't be blank")
  end

  it "invalid with name has already taken" do 
    user_one = create(:user)
    user_two = build(:user)

    user_two.valid? 

    expect(user_two.errors.full_messages).to include("Username has already been taken")
  end

  it "is has one deposit" do
    user = create(:user)
    deposit = create(:deposit, user: user)

    expect(user.deposit.amount).to eq(0)
  end
end
