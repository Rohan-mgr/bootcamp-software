require 'faker'

FactoryBot.define do
  factory :driver do
    name { Faker::Name.name }
    email { Faker::Internet.email(domain: 'example.com') }
    phone { Faker::PhoneNumber.phone_number }
    status { "active" }
  end
end
