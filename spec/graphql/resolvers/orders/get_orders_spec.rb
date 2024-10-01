require "rails_helper"

RSpec.describe Resolvers::Orders::GetOrders, type: :graphql do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }
  let!(:customer) { create(:customer) }
  let!(:order_group) { create_list(:order_group, 3, :with_delivery_order, customer: customer, user: user, organization: organization) }

  it "is successfull" do
    ActsAsTenant.with_tenant(organization) do
      result = execute_graphql(orders_query, variables: {}, context: { current_user: user })
      expect(result.dig("data", "getOrders", "orders")).not_to be_nil
      expect(result.dig("data", "getOrders", "errors")).to eq([])
    end
  end

  def orders_query
    <<~GQL
      query GetOrders {
        getOrders {
          orders {
            id
            status
            startedAt
            completedAt
            cancelledAt
            parentOrderId
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
