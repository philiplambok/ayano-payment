require 'rails_helper'

RSpec.describe Role, type: :model do
  it "is valid with name do" do 
    role = build(:role, name: "test")
    role.valid? 

    expect(role.errors.full_messages).to be_empty
  end

  it "is invalid without name" do 
    role = build(:role, name: nil)
    role.valid?

    expect(role.errors.full_messages).to include("Name can't be blank")
  end

  it "is invalid with name has already been taken" do 
    role_one = create(:role)
    role_two = build(:role)
    role_two.valid? 

    expect(role_two.errors.full_messages).to include("Name has already been taken")
  end
end
