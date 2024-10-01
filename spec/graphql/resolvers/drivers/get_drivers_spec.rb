require "rails_helper"

RSpec.describe Resolvers::Drivers::GetDrivers, type: :graphql do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }
  let!(:drivers) { create_list(:driver, 3, user: user, organization: organization) }

  it "is successful" do
    ActsAsTenant.with_tenant(organization) do
      result = execute_graphql(get_drivers_query, variables: {}, context: { current_user: user })
      expect(result.dig("data", "getDrivers", "drivers")).not_to eq([])
    end
  end

  def get_drivers_query
    <<~GQL
      query GetDrivers{
        getDrivers {
          drivers {
            id
            name
            email
            status
            phone
          }
          errors
        }
      }
    GQL
  end
end
