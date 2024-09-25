module Resolvers
  module Products
    class ProductResolver < BaseResolver
      type Types::Products::ProductResponseType, null: true

      def resolve
        begin
          product_service = ::Products::ProductService.new.execute_find_product

          if product_service.success?
            {
              products: product_service.products,
              errors: []
            }
          else
            raise product_service.errors
          end
        end
      rescue GraphQL::ExecutionError => err
        {
          products: nil,
          errors: [ err.message ]
        }
      end
    end
  end
end
