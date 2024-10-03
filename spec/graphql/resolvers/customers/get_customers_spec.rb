require "rails_helper"

RSpec.describe Resolvers::Customers::GetCustomers, type: :graphql do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }
  let!(:customers) { create_list(:customer, 3) }
  let!(:memberships) { customers.map { |customer| create(:membership, organization: organization, customer: customer) } }


  it "is successful" do
    ActsAsTenant.with_tenant(organization) do
      result = execute_graphql(get_customers_query, variables: {}, context: { current_user: user })
      expect(result.dig("data", "getCustomers", "customers")).not_to eq([])
    end
  end

  def get_customers_query
    <<~GQL
     query GetCustomers {
        getCustomers {
          customers {
            id
            name
            email
            address
            zipcode
            phoneNo
          }
          errors
        }
      }
    GQL
  end
end
