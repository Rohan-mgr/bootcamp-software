module Mutations
  module Assets
    class EditAsset < Mutations::BaseMutation
      argumet :id, ID, require: true
      argument :asset, Types::InputObjects::AssetInputType, require: true
      field :asset, Types::Assets::AssetType, null: false
      field :errors, [ String ], null: false

      def resolve(id:, asset:)
          unless context[:create_user]&.admin?
          raise GraphQL::ExecutionError, "You are not authorized to  perform this action"
          end

          service = ::Assets::EditAssetService.new(id, asset.to_h)
          updated_asset, errors = service.all
           if updated_asset
             {
              asset: updated_asset,
              errors: []
             }
           else
              {
                asset: nil,
                errors: []
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
