module Mutations
  module Products
    class UpdateProduct < BaseMutation
      argument :product_info, Types::InputObjects::ProductInputType, required: true
      argument :id, ID, required: true

      field :product, Types::Products::ProductType, null: true
      field :errors, [ String ], null: true

      def resolve(id:, product_info: {})
        begin
          product_service = ::Products::ProductService.new(product_info.to_h.merge(id: id, current_user: context[:current_user])).execute_update_product

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
