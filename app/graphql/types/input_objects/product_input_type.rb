module Types
  module InputObjects
    class ProductInputType < BaseInputObject
      argument :name, String, required: true
      argument :product_category, String, required: true
      argument :product_status, Enums::Products::ProductStatusEnum, required: true
      argument :product_unit, Enums::Products::ProductUnitEnum, required: true
    end
  end
end
