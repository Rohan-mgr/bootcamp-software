require "rails_helper"

RSpec.describe Mutations::Customers::UpdateCustomer, type: :graphql do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }
  let!(:customer) { create(:customer) }

  it "is successfull" do
    customer_info = {
      name: "Ilam Oil Corporation",
      phoneNo: "9809876543",
      zipcode: 4600,
      email: "simara.nepal@gmail.com",
      address: "Simara, Bara"
    }


    ActsAsTenant.with_tenant(organization) do
      result = execute_graphql(customer_updation_query, variables: { id: customer.id, customerInfo: customer_info }, context: { current_user: user })
      expect(result.dig("data", "updateCustomer", "customer")).not_to be_nil
    end
  end

  def customer_updation_query
    <<~GQL
      mutation UpdateCustomer($id: ID!, $customerInfo: CustomerRegistrationInput!){
        updateCustomer(input:{id: $id, customerInfo: $customerInfo}){
          customer{
            id
            name
            phoneNo
            email
            zipcode
            address
          }
          errors
        }
      }
    GQL
  end
end
