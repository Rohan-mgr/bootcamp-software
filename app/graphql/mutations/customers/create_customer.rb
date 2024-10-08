module Mutations
  module Customers
    class CreateCustomer < BaseMutation
      argument :customer_info, Types::InputObjects::CustomerRegistrationInputType, required: true

      field :customer, Types::Customers::CustomerType, null: true
      field :errors, [ String ], null: true

      def resolve(customer_info: {})
        begin
          customer_service = ::Customers::CustomerService.new(customer_info.to_h).execute_create_customer
          if customer_service.success?
            {
              customer: customer_service.customer,
              errors: []
            }
          else
            raise customer_service.errors
          end
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
