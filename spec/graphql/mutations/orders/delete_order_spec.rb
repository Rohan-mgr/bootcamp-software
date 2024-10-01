require "rails_helper"

RSpec.describe Mutations::Orders::DeleteOrder, type: :graphql do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }
  let!(:customer) { create(:customer) }
  let!(:order_group) { create(:order_group, :with_delivery_order, customer: customer, user: user, organization: organization) }

  it "deletes the order group successfully" do
    ActsAsTenant.with_tenant(organization) do
      result = execute_graphql(delete_order_query, variables: { orderId: order_group.id }, context: { current_user: user })


      expect(result.dig("data", "deleteOrder", "deletedOrder")).not_to be_nil
      expect(result.dig("data", "deleteOrder", "errors")).to be_empty
      expect(OrderGroup.count).to eq(0)
    end
  end

  def delete_order_query
    <<~GQL
      mutation DeleteOrder($orderId: ID!) {
        deleteOrder(input:{orderId: $orderId}) {
          deletedOrder {
            id
            status
            startedAt
            completedAt
            cancelledAt
            customer {
              id
              name
              email
            }
            user {
              id
              name
              email
            }
            organizationId
            createdAt
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
              asset {
                id
                assetId
                assetCategory
              }
              driver {
                id
                name
                email
              }
              createdAt
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
