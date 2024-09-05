module Types
  module Enums
    module Products
      class ProductUnitEnum < BaseEnum
        ::Product::ProductUnit::UNITS.each do |name, value|
          value(name, value)
        end
      end
    end
  end
end
