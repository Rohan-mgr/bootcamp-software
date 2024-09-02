module Mutations
  module Assets
    class EditAsset < Mutations::BaseMutation
      argumet :id, ID, require: true
      argument :asset, Types::InputObjects::AssetInputType, require: true
      field :asset, Types::Assets::AssetType, null: false
      field :errors, [ String ], null: false

      def resolve(id:, asset:)
        existing_asset = Asset.find(id)
        if existing_asset.update(
          name: asset[:name],
          asset_status: asset[:asset_status],
          asset_category: asset[:asset_category]
        )
        { asset: existing_asset, error: [] }
        else
          { asset: nil, errors: existing_asset.errors.full_messages }

        end
      end
    end
  end
end
