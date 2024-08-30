module Asset::AssetCategory
 extend ActiveSupport::Concern

  included do 
    enum asset_category:{
    trailer: "Trailer",
    truck: "Truck",
    tank_wagon: "Tank_wagon",
    tanker: "Tanker"
   }
  end
end