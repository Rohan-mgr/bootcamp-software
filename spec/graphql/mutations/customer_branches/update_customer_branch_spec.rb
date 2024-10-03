require "rails_helper"

RSpec.describe Mutations::CustomersBranch::UpdateCustomerBranch, type: :graphql do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }
  let!(:customer) { create(:customer) }
  let!(:customer_branch) { create(:customer_branch, customer: customer) }

  it "is successful" do
    branch_info = {
      name: "Check3Completed Petroleum Pvt.Ltd",
      location: "BiratnagarChowk, Nepal",
      customerId: customer.id
    }

    ActsAsTenant.with_tenant(organization) do
      result = execute_graphql(update_customer_branch_query, variables: { id: customer_branch.id, branchInfo: branch_info }, context: { current_user: user })
      expect(result.dig("data", "updateCustomerBranch")).not_to be_nil
    end
  end

  def update_customer_branch_query
    <<~GQL
     mutation UpdateCustomerBranch($id: ID!, $branchInfo: CustomerBranchInput!){
        updateCustomerBranch(input:{id: $id, branchInfo: $branchInfo}){
          customerBranch {
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
