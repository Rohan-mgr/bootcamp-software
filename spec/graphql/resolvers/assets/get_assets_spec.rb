require "rails_helper"

RSpec.describe Resolvers::Assets::GetAssets, type: :graphql do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }
  let!(:assets) { create_list(:asset, 3, user: user, organization: organization) }

  it "is successful" do
    ActsAsTenant.with_tenant(organization) do
      result = execute_graphql(get_assets_query, variables: {}, context: { current_user: user })
      expect(result.dig("data", "getAssets", "assets")).not_to eq([])
    end
  end

  def get_assets_query
    <<~GQL
      query GetAssets{
        getAssets {
          assets {
            id
            assetId
            assetCategory
            assetStatus
            userId
            organizationId
          }
          errors
        }
      }
    GQL
  end
end
