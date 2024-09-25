module Resolvers
  module Drivers
    class GetDrivers < BaseResolver
      type Types::Drivers::DriverResponseType, null: true

      def resolve
        begin
          driver_service = ::Drivers::DriverService.new.execute_fetch_driver
          if driver_service.success?
            {
              drivers: driver_service.driver,
              errors: []
            }
          else
              raise driver_service.errors
          end
        end
      rescue GraphQL::ExecutionError => err
        {
          drivers: nil,
          errors: [ err.message ]
        }
      end
    end
  end
end
