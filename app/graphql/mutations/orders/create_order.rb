module Mutations
  module Orders
    class CreateOrder < BaseMutation
      argument :order_group_info, Types::InputObjects::OrderGroupInputType, required: true

      field :message, String, null: false
      field :errors, [ String ], null: true

      def resolve(order_group_info: {})
        begin
          order_service = ::Orders::OrderService.new(order_group_info.to_h).execute_order_creation
          if order_service.success?
            {
              message: "Order created successfully",
              errors: []
            }
          else
            {
              message: "Failed to created order",
              errrors: [ order_service.errors ]
            }
          end
        end
      rescue GraphQL::ExecutionError => err
        {
          errors: [ err.message ]
        }
      end
    end
  end
end
