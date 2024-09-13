module Types
  module Categories
    class CategoryType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :category_class, Enums::Categories::CategoryClassEnum, null: false
      field :organization_id, ID, null: false
      field :user_id, ID, null: false
    end
  end
end
