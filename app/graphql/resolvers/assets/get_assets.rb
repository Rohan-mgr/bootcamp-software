module Resolvers
  module Assets
    class GetAssets < BaseResolver
      type Types::Assets::AssetsResponseType, null: true

      def resolve
        begin
           asset_service = ::Assets::AssetService.new.execte_fetch_assets

           if asset_service.success?
             {
              assets: asset_service.assets,
              errors: []
             }
           else
              raise asset_service.errors
           end
        end
      rescue GraphQL::ExecutionError => err
        {
          assets: nil,
          errors: [ err.message ]
        }
      end
    end
  end
end
