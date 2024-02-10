# In spec/factories/users.rb

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password123' } # Set a default password
    confirmed_at { Time.zone.now } # Set confirmed_at to simulate confirmation

    # Add traits to set Devise module attributes to nil
    trait :without_database_authenticatable do
      encrypted_password { nil }
    end

    trait :without_registerable do
      sign_in_count { nil }
    end

    trait :without_recoverable do
      reset_password_token { nil }
      reset_password_sent_at { nil }
    end

    trait :without_rememberable do
      remember_created_at { nil }
    end

    trait :without_validatable do
      email { nil }
    end

    trait :without_confirmable do
      confirmation_token { nil }
      confirmed_at { nil }
      confirmation_sent_at { nil }
    end
  end
end
