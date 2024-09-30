require "rails_helper"

RSpec.describe Mutations::Products::DeleteProduct, type: :graphql do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }
  let!(:product) { create(:product, user: user, organization: organization) }

  it "is successfull" do
    ActsAsTenant.with_tenant(organization) do
      result = execute_graphql(delete_product_query, variables: { id: product.id }, context: { current_user: user })
      expect(result["data"]["deleteProduct"]["product"]).not_to be_nil
    end
  end

  def delete_product_query
    <<~GQL
      mutation DeleteProduct($id: ID!) {
        deleteProduct(input:{id:$id}) {
          product {
            id
            name
            productStatus
            productUnit
            productCategory
          }
          errors
        }
      }
    GQL
  end
end
