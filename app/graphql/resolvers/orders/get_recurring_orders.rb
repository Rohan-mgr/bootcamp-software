module Resolvers
  module Orders
    class GetRecurringOrders < BaseResolver
      type Types::Orders::OrderResponseType, null: true

      def resolve
        begin
          order_service = ::Orders::OrderService.new.execute_fetch_recurring_orders

          if order_service.success?
            {
              orders: order_service.orders,
              errors: []
            }
          else
            {
              orders: nil,
              errors: [ order_service.errors ]
            }
          end
        end
      rescue GraphQL::ExecutionError => err
        {
          orders: nil,
          errors: [ err.message ]
        }
      end
    end
  end
end
