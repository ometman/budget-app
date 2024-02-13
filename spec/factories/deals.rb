FactoryBot.define do
  factory :deal do
    sequence(:name) { |n| "Deal #{n}" }
    amount { rand(100..500) } # Random amount between 100 and 500
    association :user
  end
end
