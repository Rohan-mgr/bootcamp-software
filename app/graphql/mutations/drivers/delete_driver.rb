module Mutations
  module Drivers
    class DeleteDriver < Mutations::BaseMutation
      argument :id, ID, required: true

      field :driver, Types::Drivers::DriverType, null: true
      field :message, String, null: false
      field :errors, [ String ], null: false

      def resolve(id:)
        begin
            driver_service = ::Drivers::DriverService.new({ id: id }.to_h.merge(current_user: context[:current_user])).execute_delete_driver

            if driver_service.success?
              {
                driver: driver_service.driver,
                message: "Driver deleted successfully",
                errors: []
              }
            else
              {
                driver: nil,
                message: "Failed to delete",
                errors: [ driver_service.errors ]
              }
            end
        end
      rescue GraphQL::ExecutionError => e
          {
            driver: nil,
            message: "Failed to delete",
            errorrs: [ e.message ]
          }
      end
    end
  end
end
