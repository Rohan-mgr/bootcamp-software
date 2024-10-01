require "rails_helper"

RSpec.describe Resolvers::Orders::GetRecurringOrders, type: :graphql do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }
  let!(:customer) { create(:customer) }
  let!(:order_group) { create_list(:order_group, 3, :recurring, :with_delivery_order, customer: customer, user: user, organization: organization) }

  it "is successfull" do
    ActsAsTenant.with_tenant(organization) do
      result = execute_graphql(orders_query, variables: {}, context: { current_user: user })
      expect(result.dig("data", "getRecurringOrders", "orders")).not_to eq([])
      expect(result.dig("data", "getRecurringOrders", "errors")).to eq([])
    end
  end

  def orders_query
    <<~GQL
      query GetRecurringOrders {
        getRecurringOrders {
          orders {
            id
            status
            startedAt
            completedAt
            cancelledAt
            parentOrderId
            recurring {
              frequency
              startedAt
              endAt
            }
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
