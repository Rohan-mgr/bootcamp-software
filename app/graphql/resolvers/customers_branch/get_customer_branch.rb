module Resolvers
  module CustomersBranch
    class GetCustomerBranch < BaseResolver
      type Types::CustomerBranch::CustomerBranchResponseType, null: false

      argument :id, ID, required: true

      def resolve(id:)
        begin
          customer_branch_service = ::CustomerBranches::CustomerBranchService.new({ id: id }).execute_fetch_customer_branch
          if customer_branch_service.success?
            {
              customer_branches: customer_branch_service.branches,
              errors: []
            }
          else
            raise customer_branch_service.errors
          end
        end
      rescue GraphQL::ExecutionError => err
        {
          customer_branches: nil,
          errors: [ err.message ]
        }
      end
    end
  end
end
