require "rails_helper"

RSpec.describe Mutations::Customers::CreateCustomer, type: :graphql do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }
  let!(:customer) { create(:customer) }

  it "is successfull" do
    customer_info = {
      name: "Simara Oil Corporation",
      phoneNo: "9809876543",
      zipcode: 4600,
      email: "simara.nepal@gmail.com",
      address: "Simara, Bara"
    }


    ActsAsTenant.with_tenant(organization) do
      result = execute_graphql(customer_creation_query, variables: { customerInfo: customer_info }, context: { current_user: user })
      expect(result.dig("data", "createCustomer", "customer")).not_to be_nil
    end
  end

  def customer_creation_query
    <<~GQL
     mutation CreateCustomer($customerInfo: CustomerRegistrationInput!){
        createCustomer(input:{customerInfo: $customerInfo}){
          customer{
            id
            name
            phoneNo
            email
            address
            zipcode
          }
          errors
        }
      }
      GQL
  end
end
