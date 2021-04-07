FactoryBot.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email
    username { "username" }
    password { "password" }
    
    factory :admin do
      admin { true }
    end
  end
end
