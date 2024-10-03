require "rails_helper"

RSpec.describe Resolvers::CustomersBranch::GetCustomerBranch, type: :graphql do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }
  let!(:customer) { create(:customer) }
  let!(:customer_branches) { create_list(:customer_branch, 3, customer: customer) }

  it "is successful" do
    ActsAsTenant.with_tenant(organization) do
      result = execute_graphql(get_customer_branches_query, variables: {}, context: { current_user: user })
      expect(result.dig("data", "getCustomerBranches", "customerBranches")).not_to eq([])
    end
  end

  def get_customer_branches_query
    <<~GQL
      query GetCustomerBranch($id:ID!) {
        getCustomerBranch(id:$id) {
          customerBranches {
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
