FactoryBot.define do
  factory :organization do
    name { Faker::Company.industry }
  end
end
