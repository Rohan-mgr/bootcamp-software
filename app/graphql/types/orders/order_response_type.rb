module Types
  module Orders
    class OrderResponseType < BaseObject
      field :orders, [ Types::Orders::OrderType ], null: true
      field :errors, [ String ], null: true
    end
  end
end
