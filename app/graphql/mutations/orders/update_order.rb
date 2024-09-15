module Mutations
  module Orders
    class UpdateOrder < BaseMutation
      argument :order_id, ID, required: true
      argument :order_info, Types::InputObjects::OrderGroupInputType, required: true

      field :message, String, null: true
      field :errors, [ String ], null: true

      def resolve(order_id:, order_info:)
        begin
          order_service = ::Orders::OrderService.new(order_info.to_h.merge(order_id: order_id, current_user: context[:current_user])).execution_order_edition
          if order_service.success?
            {
              message: "Order updated successfully",
              errors: []
            }
          else
            {
              message: "Failed to update order!",
              errors: [ order_service.errors ]
            }
          end
        end
      rescue GraphQL::ExecutionError => err
        {
          message: "Failed to update order!",
          errors: [ err.message ]
        }
      end
    end
  end
end
