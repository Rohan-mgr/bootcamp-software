class Asset < ApplicationRecord
  include Asset::AssetCategoryEnum
  include Asset::AssetStatusEnum
  belongs_to :user
  acts_as_tenant :organization
end
