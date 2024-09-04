module Resolvers
  module Customers
    class GetCustomers < BaseResolver
      type Types::Customers::CustomerResponseType, null: true

      def resolve
        begin
          customer_service = ::Customers::CustomerService.new.execute_fetch_customers
          if customer_service.success?
            {
              customers: customer_service.customers,
              errors: []
            }
          else
            {
              customers: nil,
              errors: [ customer_service.errors ]
            }
          end
        end
      rescue GraphQL::ExecutionError => err
        {
          customers: nil,
          errors: [ err.message ]
        }
      end
    end
  end
end
