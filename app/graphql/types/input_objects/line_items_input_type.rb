module Types
  module InputObjects
    class LineItemsInputType < BaseInputObject
      argument :name, String, required: false
      argument :quantity, Float, required: false
      argument :units, String, required: false
      argument :delivery_order_id, String, ID, required: false
    end
  end
end
