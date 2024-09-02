module Types
  module Enums
    module Products
      class ProductStatusEnum < BaseEnum
        ::Product::ProductStatus::STATUS.each do |name, value|
          value(name, value)
        end
      end
    end
  end
end
