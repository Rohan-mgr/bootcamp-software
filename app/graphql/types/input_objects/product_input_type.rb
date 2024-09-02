module Types
  module InputObjects
    class ProductInputType < BaseObject
      argument :name, String, require: true
      argument :category, Enums::Products::ProductCategoryEnum, required: true
      argument :status, Enums::Products::ProductStatusEnum
      argument :unit, Enums::Products::ProductUnitEnum
      argument :organization_id, ID, require: true
      argument :user_id, ID, require: true
    end
  end
end
