require "rails_helper"

RSpec.describe Mutations::Customers::DeleteCustomer, type: :graphql do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }
  let!(:customer) { create(:customer) }


    it "is successfull" do
      ActsAsTenant.with_tenant(organization) do
        result = execute_graphql(customer_deletion_query, variables: { id: customer.id }, context: { current_user: user })
        expect(result.dig("data", "deleteCustomer")).not_to be_nil
      end
  end

  def customer_deletion_query
    <<~GQL
      mutation DeleteCustomer($id: ID!){
        deleteCustomer(input:{id: $id}){
          customer{
            id
            name
            email
            zipcode
            phoneNo
            address
          }
          errors
        }
      }
    GQL
  end
end
