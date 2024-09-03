module Types
  module Customers
    class CustomerResponseType < BaseObject
      field :customers, [ Types::Customers::CustomerType ], null: true
      field :errors, [ String ], null: true
    end
  end
end
