require "rails_helper"

RSpec.describe Mutations::Drivers::DeleteDriver, type: :graphql do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }
  let!(:driver) { create(:driver, user: user, organization: organization) }

  it "is successfull" do
    ActsAsTenant.with_tenant(organization) do
      result = execute_graphql(delete_driver_query, variables: { id: driver.id }, context: { current_user: user })
      expect(result.dig("data""deleteDriver")).not_to eq([])
    end
  end

  def delete_driver_query
    <<~GQL
      mmutation DeleteDriver($id:ID!){
        deleteDriver(input:{id: $id}) {
          message
          errors
        }
      }
    GQL
  end
end
