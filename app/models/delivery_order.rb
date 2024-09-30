class DeliveryOrder < ApplicationRecord
  belongs_to :customer_branch
  belongs_to :asset, optional: true

  belongs_to :order_group
  has_many :line_items, dependent: :destroy
  accepts_nested_attributes_for :line_items, allow_destroy: true

  belongs_to :driver, optional: true
end
