# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# [ "Himal Lubricants Pvt.Ltd", "Sahara Gas Industry Pvt. Ltd.", "NARAYANI OIL AND REFINARY UDYOG.PVT. LTD.", "ADARSH OIL INDUSTRIES" ].each do |orgName|
#   Organization.create(name: orgName)
# end

Asset.create([
  {
    name: "Truck",
    asset_status: "active",
    asset_category: "truck",
    organization_id: 1,
    user_id: 1
  },
  {
    name: "Trailer",
    asset_status: "inactive",
    asset_category: "trailer",
    organization_id: 2,
    user_id: 2
  },
  {
    name: "Tanker",
    asset_status: "active",
    asset_category: "tanker",
    organization_id: 1,
    user_id: 1
  },
  {
    name: "Tank Wagon",
    asset_status: "inactive",
    asset_category: "tank_wagon",
    organization_id: 2,
    user_id: 2
  }
])


