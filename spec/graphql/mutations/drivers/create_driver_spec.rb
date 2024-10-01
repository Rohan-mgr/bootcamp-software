require "rails_helper"

RSpec.describe Mutations::Drivers::CreateDriver, type: :graphql do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }

  it "is successfull" do
    driver_info = {
      name: "krisha",
      email: "ankidhital@gmail.com",
      phone: "9855117767",
      status: "inactive"
    }

    ActsAsTenant.with_tenant(organization) do
      result = execute_graphql(driver_creation_query, variables: { driverInfo: driver_info }, context: { current_user: user })
      expect(result.dig("data", "createDriver", "driver")).not_to be_nil
    end
  end

  def driver_creation_query
    <<~GQL
      mutation CreateDriver($driverInfo:DriverInput!){
        createDriver(input:{driverInfo:$driverInfo}) {
          driver {
            id
            name
            email
            phone
            status
          }
          errors
         }
        }
      GQL
  end
end
