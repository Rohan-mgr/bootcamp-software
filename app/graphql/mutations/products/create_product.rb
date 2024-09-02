module Mutations
  module Products
    class CreateProducts < BaseMutation
      argument :name, String
      argument :product_category, String
      argument :product_status, String
      argument :product_unit, String
    end
  end
end
