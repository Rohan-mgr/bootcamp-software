module Asset::AssetStatus
 extend ActiveSupport::Concern
  included do 
    enum asset_status: {
    active: "Active",
    inactive: "Inactive"
   }
  end
end