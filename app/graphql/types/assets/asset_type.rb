# frozen_string_literal: true

module Types
  module Assets
    class AssetType < Types::BaseObject
      field :id, ID, null: false
      field :name, String
      field :asset_status, String, resolve: ->(obj, _args, _ctx){
        Asset.asset_statuses.key(obj.asset_status)
      }

      field :asset_category, String,resolve: ->(obj, _args, _ctx){
        Asset.asset_statuses.key(obj.asset_status)
      }

      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end
