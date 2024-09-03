module Mutations
  module Assets
    class CreateAsset < Mutations::BaseMutation
      argument :asset_info, Types::InputObjects::AssetInputType, required: true
      field :asset, Types::Assets::AssetType, null: false
      field :errors, [ String ], null: false

      def resolve(asset_info: {})
        service = ::Assets::CreateAssetService.new(asset_info.to_h)
        asset, errors =service.call
          if asset
            {
              asset: asset,
              errors: []
            }
          else
            {
              asset: nil,
              errors: errors
            }
          end
        rescue GraphQL::ExecutionError => err
          {
            asset: nil,
            errors: [ err.message ]

          }
      end
    end
  end
end
