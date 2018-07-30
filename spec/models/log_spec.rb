require 'rails_helper'

RSpec.describe Log, type: :model do
  it "valid with message" do 
    log = build(:log)

    expect(log.errors.full_messages).to be_empty
  end
end
