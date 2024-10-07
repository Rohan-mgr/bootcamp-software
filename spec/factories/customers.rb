require 'faker'

FactoryBot.define do
  factory :customer do
    name { Faker::Company.name }
    phone_no { Faker::PhoneNumber.phone_number }
    zipcode { Faker::Address.zip_code }
    email { Faker::Internet.email(domain: 'example.com') }
    address { Faker::Address.full_address }
  end
end
