module Resolvers
  module Products
    class ProductResolver < BaseResolver
      type Types::Products::ProductType, null: true
      argument :product_id, ID, required: true

      def product(id:)
        Product.find(product_id)
      end
    end
  end
end
