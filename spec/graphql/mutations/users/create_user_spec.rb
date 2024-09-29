require 'rails_helper'

RSpec.describe Mutations::Users::CreateUser, type: :graphql do
  let!(:organization) { create(:organization) }

  it "is successful" do
    result = execute_graphql(user_register_query, variables: { userInfo: { name: "Rohan Rana Magar", email: "rohan.magar@fleetpanda.com", password: "Test@123", passwordConfirmation: "Test@123", organizationId: organization.id, roles: "admin" } })
    expect(result["data"]["createUser"]["errors"]).to eq([])
  end

  def user_register_query
    <<~GQL
      mutation CreateUser($userInfo: UserRegistrationInput!) {
        createUser(input:{userInfo: $userInfo}) {
          errors
          message
        }
      }
    GQL
  end
end
