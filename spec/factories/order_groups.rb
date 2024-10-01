FactoryBot.define do
  factory :order_group do
    status { "pending" }
    started_at { "2024-10-01T12:01:54+00:00" }
    association :customer

    after(:build) do |order_group, evaluator|
      if evaluator.recurring
        order_group.recurring = {
          frequency: "daily",
          started_at: "2024-10-02T12:01:54+00:00",
          end_at: "2024-10-03T12:01:54+00:00"
        }
      else
        order_group.recurring = nil
      end
    end

    trait :with_delivery_order do
      after(:build) do |order_group|
        organization = create(:organization)
        user = create(:user, organization: organization)

        order_group.delivery_order_attributes = {
          planned_at: "2024-10-01T12:01:54+00:00",
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
