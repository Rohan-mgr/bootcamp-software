require "rails_helper"

RSpec.describe Mutations::Products::UpdateProduct, type: :graphql do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }
  let!(:product) { create(:product, user: user, organization: organization) }

  it "is successful" do
    product_info = {
      name: "Premium kerosene",
      productCategory: "kerosene",
      productStatus: "out_of_stock",
      productUnit: "liters"
    }

    ActsAsTenant.with_tenant(organization) do
      result = execute_graphql(update_product_query, variables: { id: product.id, productInfo: product_info }, context: { current_user: user })
      expect(result.dig("data", "updateProduct", "product")).not_to be_nil
    end
  end

  def update_product_query
    <<~GQL
      mutation UpdateProduct($id: ID!, $productInfo:ProductInput!){
      updateProduct(input:{id: $id, productInfo: $productInfo}){
      product {
        id
        name
        productCategory
        productStatus
        productUnit
      }
      errors
      }
     }
    GQL
  end
end
