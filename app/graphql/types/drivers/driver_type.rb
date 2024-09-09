module Types
  module Drivers
    class DriverType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :phone, String, null: false
      field :email, String, null: true
      field :status, String, Enums::Drivers::DriverStatusEnum, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :organization_id, ID, null: false
      field :user_id, ID, null: false
    end
  end
end
