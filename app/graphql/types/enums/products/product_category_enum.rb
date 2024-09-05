module Types
  module Enums
    module Products
      class ProductCategoryEnum < BaseEnum
        ::Product::ProductCategory::CATEGORY.each do |name, value|
          value(name, value)
        end
      end
    end
  end
end
