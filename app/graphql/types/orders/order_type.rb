# frozen_string_literal: true

module Types
  module Orders
    class OrderType < Types::BaseObject
      field :id, ID, null: false
      field :status, Enums::Orders::OrderStatusEnum, null: false
      field :started_at, GraphQL::Types::ISO8601DateTime
      field :completed_at, GraphQL::Types::ISO8601DateTime
      field :customer, Customers::CustomerType, null: false
      field :recurring, Types::Orders::RecurringType, null: true
      field :organization_id, ID, null: false
      field :parent_order_id, ID, null: true
      field :user, Types::Users::UserType, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :delivery_order, Types::Orders::DeliveryOrderType, null: true
    end
  end
end
