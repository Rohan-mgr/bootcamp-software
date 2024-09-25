module Mutations
  module CustomersBranch
    class CreateCustomerBranch < BaseMutation
      argument :branch_info, Types::InputObjects::CustomerBranchInputType, required: true

      field :customer_branch, Types::CustomerBranch::CustomerBranchType, null: true
      field :message, String, null: true
      field :errors, [ String ], null: true

      def resolve(branch_info: {})
        begin
          customer_branch_service = ::CustomerBranches::CustomerBranchService.new(branch_info.to_h).execute_branch_creation

          if customer_branch_service.success?
            {
              customer_branch: customer_branch_service.branch,
              message: "Customer branch created successfully",
              errors: []
            }
          else
            raise customer_branch_service.errors
          end
        end

      rescue GraphQL::ExecutionError => err
        {
          message: err.message,
          errors: [ err.message ]
        }
      end
    end
  end
end
