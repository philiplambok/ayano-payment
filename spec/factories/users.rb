FactoryBot.define do
  factory :user do
    username "MyString"
    password "kelapa"
    password_confirmation "kelapa"
    association :role, factory: :role, strategy: :build 
  end
end
