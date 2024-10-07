require "rails_helper"
require 'faker'

RSpec.describe Mutations::Orders::UpdateOrder, type: :graphql do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }
  let!(:customer) { create(:customer) }
  let!(:customer_branch) { create(:customer_branch, customer: customer) }
  let!(:asset) { create(:asset, user: user, organization: organization) }
  let!(:driver) { create(:driver, user: user, organization: organization) }
  let!(:order_group) { create(:order_group, :with_delivery_order, customer: customer, user: user, organization: organization) }

  it "updates the order group successfully" do
    order_info = {
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
      result = execute_graphql(order_update_query, variables: { orderId: order_group.id, orderInfo: order_info }, context: { current_user: user })


      expect(result.dig("data", "editOrder", "errors")).to be_empty
    end
  end

  def order_update_query
    <<~GQL
      mutation EditOrder($orderId: ID!, $orderInfo: OrderGroupInput!){
        editOrder(input: {orderId: $orderId, orderInfo: $orderInfo}){
          message
          errors
        }
      }
    GQL
  end
end
