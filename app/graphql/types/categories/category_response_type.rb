module Types
  module Categories
    class CategoryResponseType < Types::BaseObject
      field :categories, [ Types::Categories::CategoryType ], null: true
      field :errors, [ String ], null: true
    end
  end
end
