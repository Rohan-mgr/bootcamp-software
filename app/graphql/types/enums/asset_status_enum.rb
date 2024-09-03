module Types
  module Enums
    class AssetStatusEnum < BaseEnum
      ::Asset::AssetStatusEnum::STATUS.each do |name, value|
        value(name, value)
      end
    end
  end
end
