module Mutations
  module Assets
    class DeleteAsset < Mutations::BaseMutation
      argument :id, ID, required: true
      field :asset, Types::Assets::AssetType, null: false
      field :message, String, null: false
      field :errors, [ String ], null: false
      def resolve(id:)
        begin
            asset_service = ::Assets::AssetService.new({ id: id }.to_h.merge(current_user: context[:current_user])).execute_delete_asset
            if asset_service.success?
              {
                asset: asset_service.asset,
                message: "Asset deleted successfully",
                errors: []
              }
            else
              {
                message: "Failed to delete",
                errors: [ asset_service.errors ]
              }
            end
        end
      rescue GraphQL::ExecutionError =>e
          {
            message: false,
            errors: [ e.message ]
          }
      end
    end
  end
end
