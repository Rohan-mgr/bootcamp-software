require "rails_helper"

RSpec.describe Mutations::Products::CreateProduct, type: :graphql do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }

  it "is successful" do
    product_info = {
      name: "Premium kerosene",
      productCategory: "kerosene",
      productStatus: "out_of_stock",
      productUnit: "liters"
    }

    ActsAsTenant.with_tenant(organization) do
      result = execute_graphql(product_creation_query, variables: { productInfo: product_info }, context: { current_user: user })
      expect(result.dig("data", "createProduct", "product")).not_to be_nil
    end
  end

  def product_creation_query
    <<~GQL
      mutation CreateProduct($productInfo: ProductInput!){
        createProduct(input:{productInfo: $productInfo}){
          product{
            id
            name
            productCategory
            productUnit
            productStatus
          }
	      	errors
        }
      }
    GQL
  end
end
