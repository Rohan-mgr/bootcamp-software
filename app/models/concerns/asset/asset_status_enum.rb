module Asset::AssetStatusEnum
 extend ActiveSupport::Concern
  STATUS = {
    active: "active",
    inactive: "inactive"
  }.freeze

  included do
    enum asset_status: STATUS
  end
end
