require 'rails_helper'

RSpec.describe Mutations::Users::UserLogin, type: :graphql do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }

  it "is successful" do
    result = execute_graphql(login_query, variables: { sessionInfo: { email: user.email, password: user.password } })
    expect(result["data"]["userSession"]["user"]).not_to be_nil
  end

  def login_query
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
end
