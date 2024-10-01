FactoryBot.define do
  factory :user do
    name { "Rohan Rana Magar" }
    sequence(:email) { |n| "rohan.magar#{n}@fleetpanda.com" }
    password { "Test@123" }
    password_confirmation { "Test@123" }
    organization_id { 1 }
    roles { "admin" }
  end
end
