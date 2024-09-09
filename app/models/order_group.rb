class OrderGroup < ApplicationRecord
  belongs_to :customer
  acts_as_tenant :organization

  has_one :delivery_order, dependent: :destroy
  accepts_nested_attributes_for :delivery_order, allow_destroy: true
end
