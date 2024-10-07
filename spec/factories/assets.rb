require 'faker'

FactoryBot.define do
  factory :asset do
    asset_id { Faker::Vehicle.license_plate }
    asset_status { "active" }
    asset_category { Faker::Vehicle.car_type }
  end
end
