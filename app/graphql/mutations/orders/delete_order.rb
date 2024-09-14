module Mutations
  module Orders
    class DeleteOrder < BaseMutation
      argument :order_id, ID, required: true

      field :deleted_order, Types::Orders::OrderType, null: true
      field :errors, [ String ], null: true

      def resolve(order_id:)
        begin
          order_service = ::Orders::OrderService.new({ order_id: order_id }.merge(current_user: context[:current_user])).execute_order_deletion
          if order_service.success?
            {
              deleted_order: order_service.order,
              errors: []
            }
          else
            {
              deleted_order: nil,
              errors: order_service.errors
            }
          end
        end
      rescue GraphQL::ExecutionError => err
        {
          deleted_order: nil,
          errors: [ err.message ]
        }
      end
    end
  end
end
