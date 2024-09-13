module Types
  module InputObjects
    class AssetInputType < BaseInputObject
      argument :id, ID, required: false
      argument :asset_id, String, required: true
      argument :asset_status, Enums::AssetStatusEnum, required: true
      argument :asset_category, Types::Enums::Categories::CategoryClassEnum, required: true
    end
  end
end
