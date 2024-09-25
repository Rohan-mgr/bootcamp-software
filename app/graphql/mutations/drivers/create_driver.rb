module Mutations
  module Drivers
    class CreateDriver < Mutations::BaseMutation
      argument :driver_info, Types::InputObjects::DriverInputType, required: true
      field :driver, Types::Drivers::DriverType, null: false
      field :errors, [ String ], null: false

      def resolve(driver_info: {})
        begin
          driver_service = ::Drivers::DriverService.new(driver_info.to_h.merge(current_user: context[:current_user])).execute_create_driver
            if driver_service.success?
              {
                driver: driver_service.driver,
                errors: []
              }
            else
              raise driver_service.errors
            end
        end
      rescue GraphQL::ExecutionError => e
          {
            driver: nil,
            errors: [ e.message ]

          }
      end
    end
  end
end
