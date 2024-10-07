require "rails_helper"
require 'faker'

RSpec.describe Mutations::Customers::UpdateCustomer, type: :graphql do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }
  let!(:customer) { create(:customer) }

  it "is successfull" do
    customer_info = {
      name: Faker::Company.name,
      phoneNo: Faker::PhoneNumber.phone_number,
      zipcode: Faker::Address.zip_code.to_i,
      email: Faker::Internet.email(domain: 'example.com'),
      address: Faker::Address.full_address
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
