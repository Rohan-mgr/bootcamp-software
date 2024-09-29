FactoryBot.define do
  factory :asset do
    sequence(:asset_id) { |n| "BA AB #{4929 + n}" }
    asset_status { "active" }
    asset_category { "Tank Wagon" }
  end
end
