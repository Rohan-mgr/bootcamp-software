# frozen_string_literal: true

module Types
  module Orders
    class LineItemType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :quantity, Float, null: false
      field :units, String, null: false
      field :delivery_order_id, Integer, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end
