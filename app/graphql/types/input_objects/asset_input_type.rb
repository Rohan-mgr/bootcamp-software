module Types
  module InputObjects
    class AssetInputType < BaseInputObject
      argument :name, String, required: true
      argument :asset_status, Enums::AssetStatusEnum, required: true
      argument :asset_category, Enums::AssetCategoryEnum, required: true
      argument :organization_id, ID, required: true
      argument :user_id, ID, required: true
    end
  end
end
