# frozen_string_literal: true

module Types
  module CustomerBranch
    class CustomerBranchType < Types::BaseObject
      field :id, ID, null: false
      field :name, String
      field :location, String
      field :customer_id, Integer, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end
