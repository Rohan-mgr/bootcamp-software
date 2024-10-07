require "rails_helper"
require 'faker'

RSpec.describe Mutations::Assets::CreateAsset, type: :graphql do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }

  it "is successful" do
    asset_info = {
      assetId: Faker::Vehicle.license_plate,
      assetCategory: Faker::Vehicle.car_type,
      assetStatus: "active"
    }

    ActsAsTenant.with_tenant(organization) do
      result = execute_graphql(asset_creation_query, variables: { assetInfo: asset_info }, context: { current_user: user })
      expect(result["data"]["createAsset"]["asset"]).not_to be_nil
    end
  end

  def asset_creation_query
     <<~GQL
      mutation CreateAsset($assetInfo:AssetInput!){
        createAsset(input:{assetInfo: $assetInfo}) {
          asset {
            id
            assetId
            assetStatus
            assetCategory
          }
          errors
        }
      }
    GQL
  end
end
