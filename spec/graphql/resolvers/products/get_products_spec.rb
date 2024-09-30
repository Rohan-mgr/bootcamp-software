require "rails_helper"

RSpec.describe Resolvers::Products::ProductResolver, type: :graphql do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }
  let!(:products) { create_list(:product, 3, user: user, organization: organization) }

  it "is successful" do
    ActsAsTenant.with_tenant(organization) do
      result = execute_graphql(get_products_query, variables: {}, context: { current_user: user })
      expect(result.dig("data", "findProducts", "products")).not_to eq([])
    end
  end

  def get_products_query
    <<~GQL
     query FindProducts {
      findProducts {
       products {
        id
        name
        productStatus
        productUnit
        productCategory
        userId
        organizationId
      }
       errors
      }
     }
    GQL
  end
end
