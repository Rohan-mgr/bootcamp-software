require 'rails_helper'

RSpec.describe Mutations::Users::CreateUser, type: :graphql do
  let (:mutation) do
    <<~GQL
      mutation CreateUser($userInfo: UserRegistrationInput!) {
        createUser(input:{userInfo: $userInfo}) {
          errors
          message
        }
      }
    GQL
  end

  it "is successful" do
    result = execute_graphql(mutation, variables: { userInfo: { name: "Rohan Rana Magar", email: "rohan.magar@fleetpanda.com", password: "Test@123", passwordConfirmation: "Test@123", organizationId: 1, roles: "admin" } })
    expect(result["data"]["createUser"]["errors"]).to eq([])
  end
end
