module Resolvers
  module Assets
    class GetAssets < BaseResolver
      type Types::Assets::AssetsResponseType, null: true

      def resolve
        begin
            assets = Asset.order(created_at: :DESC)
            {
              assets: assets,
              errors: []
            }
          # end

        rescue GraphQL::ExecutionError => err
          {
            assets: [],
            errors: [ err.message ]
          }

        end
      end
    end
  end
end
