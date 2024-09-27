class Asset < ApplicationRecord
  include Asset::AssetStatusEnum

  belongs_to :user
  acts_as_tenant :organization

  has_many :delivery_orders, dependent: :nullify
end
