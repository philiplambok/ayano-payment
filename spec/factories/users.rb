FactoryBot.define do
  factory :user do
    username "MyString"
    password "kelapa"
    password_confirmation "kelapa"
    association :role, factory: :role, strategy: :build 
  end

  factory :admin, class: User do 
    username "admin_user"
    password "kelapa"
    password_confirmation "kelapa"
    role_id 1 
  end

  factory :member, class: User do 
    username "member_user"
    password "kelapa"
    password_confirmation "kelapa"
    role_id 2
  end

  factory :hacker, class: User do 
    username "hacker"
    password "kelapa"
    password_confirmation "kelapa"
    role_id 2
  end

  factory :sample_user, class: User do 
    username "sample_user" 
    password "kelapa"
    password_confirmation "kelapa"
    role_id 2
  end
end
