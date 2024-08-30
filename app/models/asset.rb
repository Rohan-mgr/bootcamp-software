class Asset < ApplicationRecord

  include Asset::AssetCategory
  include Asset::AssetStatus
end
