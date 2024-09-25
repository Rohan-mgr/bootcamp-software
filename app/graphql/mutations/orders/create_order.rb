module Mutations
  module Orders
    class CreateOrder < BaseMutation
      argument :order_group_info, Types::InputObjects::OrderGroupInputType, required: true

      field :order, Types::Orders::OrderType, null: true
      field :errors, [ String ], null: true

      def resolve(order_group_info: {})
        begin
          order_service = ::Orders::OrderService.new(order_group_info.to_h.merge(current_user: context[:current_user])).execute_order_creation
          if order_service.success?
            {
              order: order_service.order,
              errors: []
            }
          else
            raise order_service.errors
          end
        end
      rescue GraphQL::ExecutionError => err
        {
          order: nil,
          errors: [ err.message ]
        }
      end
    end
  end
end
