module Mutations
  module CustomersBranch
    class DeleteCustomerBranch < BaseMutation
      argument :id, ID, required: true

      field :customer_branch, Types::CustomerBranch::CustomerBranchType, null: true
      field :errors, [ String ], null: true

      def resolve(id:)
        begin
          customer_branch_service = ::CustomerBranches::CustomerBranchService.new({ id: id }.to_h.merge(current_user: context[:current_user])).execute_branch_deletion
          if customer_branch_service.success?
            {
              customer_branch: customer_branch_service.branch,
              errors: []
            }
          else
            raise customer_branch_service.errors
          end
        end
      rescue GraphQL::ExecutionError => err
        {
          customer_branch: nil,
          errors: [ err.message ]
        }
      end
    end
  end
end
