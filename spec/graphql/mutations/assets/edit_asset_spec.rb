require "rails_helper"

RSpec.describe Mutations::Assets::EditAsset, type: :graphql do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }
  let!(:asset) { create(:asset, user: user, organization: organization) }

  it "is successful" do
    asset_info = {
      assetId: "B AA 6699",
      assetCategory: "Trailer",
      assetStatus: "active"
    }

    ActsAsTenant.with_tenant(organization) do
      result = execute_graphql(edit_asset_query, variables: { id: asset.id, assetInfo: asset_info }, context: { current_user: user })
      expect(result.dig("data", "editAsset", "asset")).not_to be_nil
    end
  end

  def edit_asset_query
     <<~GQL
      mutation EditAssest($id: ID!, $assetInfo:AssetInput!){
        editAsset(input:{id:, $id, assetInfo: $assetInfo}){
          asset{
            id
            assetStatus
            assetId
            assetCategory
          }
          errors
        }
      }
    GQL
  end
end
