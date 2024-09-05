module Types
  module Products
    class ProductResponseType < BaseObject
      field :products, [ Types::Products::ProductType ], null: true
      field :errors, [ String ], null: true
    end
  end
end
