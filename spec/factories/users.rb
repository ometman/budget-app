FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password123' }
    confirmed_at { Time.now }
    reset_password_token { nil } # Initialize the reset_password_token attribute

    trait :unconfirmed do
      confirmed_at { nil }
    end

    trait :confirmed do
      confirmed_at { Time.now }
    end
  end
end
