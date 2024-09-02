module Types
  module InputObjects
    class AssetInputType < BaseInputObject
      argument :name, String, requred: true
      argument :asset_status, String, require: true
      argument :asset_category, String, require: true
    end
  end
end
