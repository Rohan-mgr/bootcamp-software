module Mutations
  module Orders
    class UpdateOrder < BaseMutation
      argument :order_id, ID, required: true
      argument :order_info, Types::InputObjects::OrderGroupInputType, required: true

      field :updated_order, Types::Orders::OrderType, null: true
      field :errors, [ String ], null: true

      def resolve(order_id:, order_info:)
        begin
          order_service = ::Orders::OrderService.new(order_info.to_h.merge(order_id: order_id, current_user: context[:current_user])).execution_order_edition
          if order_service.success?
            {
              updated_order: order_service.order,
              errors: []
            }
          else
            {
              updated_order: nil,
              errors: [ order_service.errors ]
            }
          end
        end
      rescue GraphQL::ExecutionError => err
        {
          updated_order: nil,
          errors: [ err.message ]
        }
      end
    end
  end
end
