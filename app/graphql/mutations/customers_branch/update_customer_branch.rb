module Mutations
  module CustomersBranch
    class UpdateCustomerBranch < BaseMutation
      argument :branch_info, Types::InputObjects::CustomerBranchInputType, required: true
      argument :id, ID, required: true

      field :customer_branch, Types::CustomerBranch::CustomerBranchType, null: true
      field :errors, [ String ], null: true

      def resolve(id:, branch_info: {})
        begin
          customer_branch_service = ::CustomerBranches::CustomerBranchService.new(branch_info.to_h.merge(id: id, current_user: context[:current_user])).execute_branch_updation
          if customer_branch_service.success?
            {
              customer_branch: customer_branch_service.branch,
              errors: []
            }
          else
            raise customer_branch_service.errors
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
end
