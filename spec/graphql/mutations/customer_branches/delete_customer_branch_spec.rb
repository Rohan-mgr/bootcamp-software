require "rails_helper"

RSpec.describe Mutations::CustomersBranch::DeleteCustomerBranch, type: :graphql do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }
  let!(:customer) { create(:customer) }
  let!(:customer_branch) { create(:customer_branch, customer: customer) }

  it "is successfull" do
    ActsAsTenant.with_tenant(organization) do
      result = execute_graphql(delete_customer_branch_query, variables: { id: customer_branch.id }, context: { current_user: user })
      expect(result.dig("data""deleteCustomerBranch")).not_to eq([])
    end
  end

  def delete_customer_branch_query
    <<~GQL
     mutation DeleteCustomerBranch($id: ID!){
        deleteCustomerBranch(input:{id:$id}){
          customerBranch{
            id
            name
            location
            customerId
          }
          errors
        }
      }
    GQL
  end
end
