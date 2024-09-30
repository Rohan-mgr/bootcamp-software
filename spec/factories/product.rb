FactoryBot.define do
  factory :product do
    name { "Premium kerosene" }
    product_category { "kerosene" }
    product_unit { "liters" }
    product_status { "out_of_stock" }
  end
end
