module Types
  module InputObjects
    class AssetInputType < BaseInputObject
      argument :asset_id, String, required: true
      argument :asset_status, Enums::AssetStatusEnum, required: true
      argument :asset_category, String, required: true
    end
  end
end
