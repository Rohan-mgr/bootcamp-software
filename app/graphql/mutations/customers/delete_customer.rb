module Mutations
  module Customers
    class DeleteCustomer < Mutations::BaseMutation
      argument :id, ID, required: true

      field :customer, Types::Customers::CustomerType, null: true
      field :errors, [ String ], null: true

      def resolve(id:)
        begin
          customer_service = ::Customers::CustomerService.new({ id: id }.to_h.merge(current_user: context[:current_user])).execute_delete_customer
          if customer_service.success?
            {
            customer: customer_service.customer,
            errors: []
            }
          else
            {
            customer: nil,
            errors: customer_service.errors
            }
          end
        rescue GraphQL::ExecutionError => err
          {
            customer: nil,
            errors: [ err.message ]
          }
        end
      end
    end
  end
end
