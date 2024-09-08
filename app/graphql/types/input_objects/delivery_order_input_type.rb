module Types
  module InputObjects
    class DeliveryOrderInputType < BaseInputObject
      argument :planned_at, GraphQL::Types::ISO8601DateTime, required: false
      argument :status, String, required: false
      argument :completed_at, GraphQL::Types::ISO8601DateTime, required: false
      argument :customer_branch_id, ID, required: false
      argument :order_group_id, ID, required: false
      argument :asset_id, ID, required: false
      argument :line_items_attributes, [ Types::InputObjects::LineItemsInputType ], required: true
    end
  end
end
