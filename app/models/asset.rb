class Asset < ApplicationRecord
  include Asset::AssetStatusEnum

  belongs_to :user
  acts_as_tenant :organization

  has_many :delivery_orders

  before_destroy :nullify_associated_delivery_orders

  private

  def nullify_associated_delivery_orders
    delivery_orders.with_deleted.update_all(asset_id: nil)
  end
end
