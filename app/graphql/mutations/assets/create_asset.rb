module Mutations
  module Assets
    class CreateAsset < Mutations::BaseMutation
      argument :asset_info, Types::InputObjects::AssetInputType, required: true
      field :asset, Types::Assets::AssetType, null: false
      field :errors, [ String ], null: false

      def resolve(asset_info: {})
       begin
          asset_service = ::Assets::AssetService.new(asset_info.to_h.merge(current_user: context[:current_user])).execute_create_asset

            if asset_service.success?
              {
                asset: asset_service.asset,
                errors: []
              }
            else
              raise asset_service.errors
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
