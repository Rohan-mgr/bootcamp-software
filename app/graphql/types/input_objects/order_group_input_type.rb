module Types
  module InputObjects
    class OrderGroupInputType < BaseInputObject
      argument :status, Enums::Orders::OrderStatusEnum, required: true
      argument :started_at, GraphQL::Types::ISO8601DateTime, required: false
      argument :completed_at, GraphQL::Types::ISO8601DateTime, required: false
      argument :customer_id, ID, required: true
      argument :recurring, RecurringInputType, required: false
      argument :delivery_order_attributes, Types::InputObjects::DeliveryOrderInputType, required: true
    end
  end
end
