FactoryBot.define do
  factory :user do
    name { "Dummy Name" }
    email { "dummy@gmail.com" }
    password { "Test@123" }
    password_confirmation { "Test@123" }
    organization_id { 2 }
    roles { "admin" }
  end
end
