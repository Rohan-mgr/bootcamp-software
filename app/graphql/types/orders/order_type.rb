# frozen_string_literal: true

module Types
  module Orders
    class OrderType < Types::BaseObject
      field :id, ID, null: false
      field :status, String, null: false
      field :started_at, GraphQL::Types::ISO8601DateTime
      field :completed_at, GraphQL::Types::ISO8601DateTime
      field :customer_id, Integer, null: false
      field :organization_id, Integer, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :delivery_order, Types::Orders::DeliveryOrderType, null: true
    end
  end
end
