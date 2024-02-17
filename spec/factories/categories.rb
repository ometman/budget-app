FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }
    sequence(:id) { |n| n + 1 }
    association :user
  end
end
