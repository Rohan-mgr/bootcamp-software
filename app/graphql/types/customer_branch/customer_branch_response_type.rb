module Types
  module CustomerBranch
    class CustomerBranchResponseType < BaseObject
      field :customer_branches, [ Types::CustomerBranch::CustomerBranchType ], null: true
      field :errors, [ String ], null: true
    end
  end
end
