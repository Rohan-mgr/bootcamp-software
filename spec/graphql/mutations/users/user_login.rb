require 'rails_helper'

RSpec.describe Mutations::Users::UserLogin, type: :graphql do
  let!(:user) { create(:user) }

  let (:mutation) do
    <<~GQL
      mutation UserSession($sessionInfo: UserSessionInput!) {
        userSession(input:{sessionInfo: $sessionInfo}) {
          user {
            id
            name
            email
            roles
          }
          token
          errors
        }
      }
    GQL
  end

  it "is successful" do
    result = execute_graphql(mutation, variables: { sessionInfo: { email: "rohan.magar@fleetpanda.com", password: "Test@123" } })
    expect(result["data"]["userSession"]["user"]).not_to be_nil
  end
end
