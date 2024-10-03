require "rails_helper"

RSpec.describe Mutations::CustomersBranch::CreateCustomerBranch, type: :graphql do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }
  let!(:customer) { create(:customer) }

  it "is successfull" do
    branch_info = {
    name: " Romiya Oil Corporation",
    location: "Kathmandu, Nepal",
    customerId: customer.id
  }

    ActsAsTenant.with_tenant(organization) do
      result = execute_graphql(customer_branch_creation_query, variables: { branchInfo: branch_info }, context: { current_user: user })
      expect(result.dig("data", "createCustomerBranch", "customerBranch")).not_to be_nil
    end
  end

  def customer_branch_creation_query
    <<~GQL
      mutation CreateCustomerBranch($branchInfo: CustomerBranchInput!){
        createCustomerBranch(input: {branchInfo: $branchInfo}){
          customerBranch {
            id
            name
            location
            customerId
          }
          message
          errors
        }
      }
      GQL
  end
end
