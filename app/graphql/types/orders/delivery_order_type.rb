# frozen_string_literal: true

module Types
  module Orders
    class DeliveryOrderType < Types::BaseObject
      field :id, ID, null: false
      field :planned_at, GraphQL::Types::ISO8601DateTime, null: false
      field :completed_at, GraphQL::Types::ISO8601DateTime
      field :customer_branch, CustomerBranch::CustomerBranchType, null: false
      field :order_group_id, Integer, null: false
      field :asset, Assets::AssetType, null: false
      field :driver, Drivers::DriverType, null: true
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :line_items, [ Types::Orders::LineItemType ], null: true
    end
  end
end
