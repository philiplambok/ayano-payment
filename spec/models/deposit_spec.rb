require 'rails_helper'

RSpec.describe Deposit, type: :model do
  let (:user) { create(:user) }
  
  before do 
    user.open_deposit!
  end

  it "is valid with user and amount" do
    expect(user.deposit.amount).to eq(0)
  end
end
