FactoryBot.define do
  factory :deal do
    sequence(:name) { |n| "Deal #{n}" }
    amount { rand(100..500) }
    association :user
    association :category

    trait :invalid do
      name { nil }
      amount { nil }
    end
  end
end
