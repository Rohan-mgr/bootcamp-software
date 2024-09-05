module Resolvers
  module Products
    class ProductResolver < BaseResolver
      type Types::Products::ProductResponseType, null: true

      def resolve
        begin
          products = Product.order(created_at: :DESC)
          {
            products: products,
            errors: []
          }
        rescue GraphQL::ExecutionError => err
          {
            products: nil,
            errors: [ err.message ]
          }
        end
      end
    end
  end
end
