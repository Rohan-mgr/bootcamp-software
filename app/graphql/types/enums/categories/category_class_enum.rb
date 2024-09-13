module Types
  module Enums
    module Categories
      class CategoryClassEnum < BaseEnum
        ::Category::CategoryClassEnum::CATEGORY.each do |name, value|
          value(name, value)
        end
      end
    end
  end
end
