module Mutations
  module Assets 
    class CreateAsset < Mutations::BaseMutation
      argument :asset, Types::InputObjects::AssetInputType, require: true
      field :asset, Types::Assets::AssetType, null: false
      field :errors, [ String ], null: false

      def resolve
        new_asset = Asset.new(
          name: asset[:name],
          asset_status: asset[:asset_status],
          asset_category: asset[:asset_category]
        )
        if new_asset.save
          { asset: new_asset, error: [] }
        else
          { asset: nil, errors: new_asset.errors.full_messages }

        end
      end
    end
  end
end
