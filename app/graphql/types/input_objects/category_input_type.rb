module Types
  module InputObjects
    class CategoryInputType < BaseInputObject
      argument :name, String, required: true
      argument :category_class, Types::Enums::Categories::CategoryClassEnum, required: false
    end
  end
end
