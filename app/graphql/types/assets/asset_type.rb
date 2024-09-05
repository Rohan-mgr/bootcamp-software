# frozen_string_literal: true

module Types
  module Assets
    class AssetType < Types::BaseObject
      field :id, ID, null: false
      field :asset_id, String, null: false
      field :asset_status, Enums::AssetStatusEnum, null: false
      field :asset_category, Types::Enums::AssetCategoryEnum, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :organization_id, ID, null: false
      field :user_id, ID, null: false
    end
  end
end
