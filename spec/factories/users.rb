require 'faker'

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email(domain: 'example.com') }
    password { Faker::Alphanumeric.alphanumeric(number: 8) }
    password_confirmation { password }
    association :organization
    roles { "admin" }
  end
end
