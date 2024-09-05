module Types
  module Enums
    class AssetCategoryEnum < BaseEnum
      ::Asset::AssetCategoryEnum::CATEGORY.each do |name, value|
        value(name, value)
      end
    end
  end
end
