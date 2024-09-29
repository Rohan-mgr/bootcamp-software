require "rails_helper"

RSpec.describe Mutations::Assets::DeleteAsset, type: :graphql do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }
  let!(:asset) { create(:asset, user: user, organization: organization) }

  it "is successfull" do
    ActsAsTenant.with_tenant(organization) do
      result = execute_graphql(delete_asset_query, variables: { id: asset.id }, context: { current_user: user })
      expect(result.dig("data", "deleteAsset", "asset")).not_to be_nil
    end
  end

  def delete_asset_query
    <<~GQL
      mutation DeleteAsset($id:ID!){
        deleteAsset(input:{id: $id}) {
          asset {
            id
            assetId
            assetStatus
            assetCategory
            userId
            organizationId
          }
          message
          errors
        }
      }
    GQL
  end
end
