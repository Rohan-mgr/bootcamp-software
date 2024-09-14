module Types
  module InputObjects
    class RecurringInputType < BaseInputObject
      argument :frequency, Enums::Orders::RecurringEnum, required: true
      argument :started_at, GraphQL::Types::ISO8601DateTime, required: true
      argument :end_at, GraphQL::Types::ISO8601DateTime, required: true
    end
  end
end
