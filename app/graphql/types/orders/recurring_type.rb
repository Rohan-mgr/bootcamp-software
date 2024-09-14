module Types
  module Orders
    class RecurringType < BaseObject
      field :frequency, Enums::Orders::RecurringEnum, null: false
      field :started_at, GraphQL::Types::ISO8601DateTime, null: false
      field :end_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end
