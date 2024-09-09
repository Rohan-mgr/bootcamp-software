module Resolvers
  module Drivers
    class GetDrivers < BaseResolver
      type Types::Drivers::DriverResponseType, null: true

      def resolve
        begin
            drivers = Driver.order(created_at: :DESC)
            {
              drivers: drivers,
              errors: []
            }

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
