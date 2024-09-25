# frozen_string_literal: true

module Mutations
  module Products
    class DeleteProduct < BaseMutation
      # TODO: define return fields
      field :product, Types::Products::ProductType, null: true
      field :errors, [ String ], null: true

      # TODO: define arguments
      argument :id, ID, required: true

      # TODO: define resolve method
      def resolve(id:)
        begin
          product_service = ::Products::ProductService.new({ id: id }.to_h.merge(current_user: context[:current_user])).execute_delete_product
          if product_service.success?
            {
              product: product_service.product,
              errors: []
            }
          else
           raise product_service.errors
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
