module Asset::AssetCategoryEnum
 extend ActiveSupport::Concern

  CATEGORY = {
    trailer: "trailer",
    truck: "truck",
    tank_wagon: "tank_wagon",
    tanker: "tanker"
  }.freeze

  included do
    enum asset_category: CATEGORY
  end
end
