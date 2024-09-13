module Mutations
  module Drivers
    class EditDriver < BaseMutation
      argument :driver_info, Types::InputObjects::DriverInputType, required: true
      argument :id, ID, required: true

      field :driver, Types::Drivers::DriverType, null: true
      field :errors, [ String ], null: true

      def resolve(id:, driver_info: {})
        begin
          driver_service = ::Drivers::DriverService.new(driver_info.to_h.merge(id: id, current_user: context[:current_user])).execute_edit_driver

          if driver_service.success?
            {
              driver: driver_service.driver,
              errors: []
            }
          else
            {
              driver: nil,
              errors: [ driver_service.errors ]
            }
          end

        rescue GraphQL::ExecutionError => err
          {
            product: nil,
            errors: [ err.message ]
          }
        end
      end
    end
  end
end
