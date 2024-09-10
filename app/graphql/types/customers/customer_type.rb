# frozen_string_literal: true

module Types
  module Customers
    class CustomerType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :phone_no, String, null: false
      field :email, String, null: false
      field :address, String, null: false
      field :zipcode, String, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end
