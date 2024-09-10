module Mutations
  module Customers
    class UpdateCustomer < BaseMutation
      argument :customer_info, Types::InputObjects::CustomerRegistrationInputType, required: true
      argument :id, ID, required: true

      field :customer, Types::Customers::CustomerType, null: true
      field :errors, [ String ], null: true

      def resolve(id:, customer_info: {})
        begin
          customer_service = ::Customers::CustomerService.new(customer_info.to_h.merge(id: id, current_user: context[:current_user])).execute_update_customer
          if customer_service.success?
            {
              customer: customer_service.customer,
              errors: []
            }
          else
            {
              customer: nil,
              errros: [ customer_service.errors ]
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
