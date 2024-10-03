FactoryBot.define do
  factory :membership do
    association :customer
    association :organization
  end
end
