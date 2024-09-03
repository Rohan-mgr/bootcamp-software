module Types
  module InputObjects
    class ProductInputType < BaseInputObject
      argument :name, String, required: true
      argument :category, Enums::Products::ProductCategoryEnum, required: true
      argument :status, Enums::Products::ProductStatusEnum, required: true
      argument :unit, Enums::Products::ProductUnitEnum, required: true
      argument :organization_id, ID, required: true
      argument :user_id, ID, required: true
    end
  end
end
