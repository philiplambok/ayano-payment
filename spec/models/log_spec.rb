require 'rails_helper'

RSpec.describe Log, type: :model do
  let (:user) { create(:user) }
  let (:log) { build(:log, user: user) }

  it "valid with message" do 
    log.valid?

    expect(log.errors.full_messages).to be_empty
  end

  it "invalid without message" do
    log.message = nil 
    log.valid?

    expect(log.errors.full_messages).to include("Message can't be blank")
  end
end
