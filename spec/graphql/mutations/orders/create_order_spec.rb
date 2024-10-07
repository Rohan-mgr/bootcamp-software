require 'faker'
require "rails_helper"

RSpec.describe Mutations::Orders::CreateOrder, type: :graphql do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }
  let!(:customer) { create(:customer) }
  let!(:customer_branch) { create(:customer_branch, customer: customer) }
  let!(:asset) { create(:asset, user: user, organization: organization) }
  let!(:driver) { create(:driver, user: user, organization: organization) }

  it "is successful" do
    order_group_info = {
      status: "pending",
      startedAt: Faker::Time.backward(days: 14).iso8601,
      customerId: customer.id,
      deliveryOrderAttributes: {
        plannedAt: Faker::Time.backward(days: 14).iso8601,
        customerBranchId: customer_branch.id,
        assetId: asset.id,
        driverId: driver.id,
        lineItemsAttributes: [
          {
            name: "lpg",
            quantity: 20,
            units: "liters"
          },
          {
            name: "diesel",
            quantity: 5,
            units: "liters"
          }
        ]
      }
    }
    ActsAsTenant.with_tenant(organization) do
      result = execute_graphql(order_creation_query, variables: { orderGroupInfo: order_group_info }, context: { current_user: user })
      expect(result.dig("data", "createOrder", "order")).not_to be_nil
    end
  end

  def order_creation_query
    <<~GQL
      mutation CreateOrder($orderGroupInfo: OrderGroupInput!) {
        createOrder(input: { orderGroupInfo: $orderGroupInfo }) {
          order {
            id
            status
            startedAt
            completedAt
            parentOrderId
            customer {
              id
              name
              email
            }
            organizationId
            user {
              id
              name
              email
            }
            recurring {
              frequency
              startedAt
              endAt
            }
            deliveryOrder {
              id
              plannedAt
              completedAt
              customerBranch {
                id
                name
                location
              }
              orderGroupId
              asset{
                id
                assetId
                assetCategory
              }
              driver{
                id
                name
                email
              }
              lineItems {
                id
                name
                quantity
                units
                deliveryOrderId
              }
            }
          }
          errors
        }
      }
    GQL
  end
end
