FactoryBot.define do
  factory :user do
    name { "Rohan Rana Magar" }
    email { "rohan.magar@fleetpanda.com" }
    password { "Test@123" }
    password_confirmation { "Test@123" }
    organization_id { 1 }
    roles { "admin" }
  end
end
