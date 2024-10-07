FactoryBot.define do
  factory :order_group do
    status { "pending" }
    started_at { Faker::Time.backward(days: 14).iso8601 }
    association :customer

    trait :recurring do
      after(:build) do |order_group, evaluator|
        if evaluator.recurring
          order_group.recurring = {
            frequency: "daily",
            started_at: Faker::Time.forward(days: 365).iso8601,
            end_at: Faker::Time.forward(days: 365).iso8601
          }
        else
          order_group.recurring = nil
        end
      end
    end

    trait :with_delivery_order do
      after(:build) do |order_group|
        organization = create(:organization)
        user = create(:user, organization: organization)

        order_group.delivery_order_attributes = {
          planned_at: Faker::Time.backward(days: 14).iso8601,
          customer_branch_id: create(:customer_branch, customer: order_group.customer).id,
          asset_id: create(:asset, user: user, organization: organization).id,
          driver_id: create(:driver, user: user, organization: organization).id,
          line_items_attributes: [
            { name: "lpg", quantity: 20, units: "liters" },
            { name: "diesel", quantity: 5, units: "liters" }
          ]
        }
      end
    end
  end
end
