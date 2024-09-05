module Mutations
  module Products
    class CreateProduct < BaseMutation
      argument :product_info, Types::InputObjects::ProductInputType, required: true

      field :product, Types::Products::ProductType, null: true
      field :errors, [ String ], null: true

      def resolve(product_info: {})
        begin
          product_service = ::Products::ProductService.new(product_info.to_h.merge(current_user: context[:current_user])).execute_create_product
          if product_service.success?
            {
              product: product_service.product,
              errors: []
            }
          else
            {
              product: nil,
              errors: product_service.errors
            }
          end
        rescue GraphQL::ExecutionError => err
          {
            product: nil,
            errors: [ err.message ]
          }
        end
      end
    end
  end
end
