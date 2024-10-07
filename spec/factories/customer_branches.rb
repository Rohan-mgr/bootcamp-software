FactoryBot.define do
  factory :customer_branch do
    name { Faker::Company.name }
    location { Faker::Address.full_address }

    association :customer
  end
end
