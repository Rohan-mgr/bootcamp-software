module Types
  module InputObjects
    class AssetInputType < BaseInputObject
      argument :id, ID, required: false
      argument :asset_id, String, required: true
      argument :asset_status, Enums::AssetStatusEnum, required: true
      argument :asset_category, Enums::AssetCategoryEnum, required: true
    end
  end
end
