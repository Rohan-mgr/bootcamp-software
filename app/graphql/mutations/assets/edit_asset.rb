module Mutations
  module Assets
    class EditAsset < Mutations::BaseMutation
      argument :asset_info, Types::InputObjects::AssetInputType, required: true
      argument :id, ID, required: true

      # argument :asset, Types::InputObjects::AssetInputType, required: true
      field :asset, Types::Assets::AssetType, null: false
      field :message, String, null: false
      field :errors, [ String ], null: false

      def resolve(id:, asset_info: {})
        begin
          asset_service = ::Assets::AssetService.new(asset_info.to_h.merge(id: id, current_user: context[:current_user])).execute_edit_asset
          if asset_service.success?
            {
              asset: asset_service.asset,
              message: "Asset Edited Successfully",
              errors: []
            }
          else
            {
              message: "Failed to edit",
              errors: [ asset_service.errors ]
            }
          end
        end
      rescue GraphQL::ExecutionError => e
        {
          asset: nil,
          errors: [ e.message ]
        }
      end
    end
  end
end
