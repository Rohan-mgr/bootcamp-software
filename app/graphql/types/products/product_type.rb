# frozen_string_literal: true

module Types
  module Products
    class ProductType < Types::Products::BaseObject
      field :id, ID, null: false
      field :name, String
      field :product_category, Enums::Products::ProductCategoryEnum
      field :product_status, Enums::Products::ProductStatusEnum
      field :product_unit, Enums::Products::ProductUnitEnum
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end
