require 'faker'
require "rails_helper"

RSpec.describe Mutations::Customers::CreateCustomer, type: :graphql do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }

  it "is successfull" do
    customer_info = {
      name: Faker::Company.name,
      phoneNo: Faker::PhoneNumber.phone_number,
      zipcode: Faker::Address.zip_code.to_i,
      email: Faker::Internet.email(domain: 'example.com'),
      address: Faker::Address.full_address
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
