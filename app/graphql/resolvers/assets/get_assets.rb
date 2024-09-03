module Resolvers
  module Assets
    class GetAssets < BaseResolver
      type Types::Assets::AssetsResponseType, null: true
      argument :organization_id, ID, required: true
  
      def resolve(organization_id:)
        begin
          org = Organization.find(organization_id)
          if org.present?
            assets = org.assets.order(created_at: :DESC)
            {
              assets: assets,
              errors: []
            }
          end

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
