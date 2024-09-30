class OrderGroup < ApplicationRecord
  include Order::OrderStatus
  scope :recurring_orders, -> { where.not(parent_order_id: nil, recurring: nil).order(created_at: :DESC) }

  belongs_to :customer
  acts_as_tenant :organization

  has_one :delivery_order, dependent: :destroy
  accepts_nested_attributes_for :delivery_order, allow_destroy: true

  belongs_to :user

  def set_recurring_details(recurring_details = nil)
    self.recurring = recurring_details
  end
end
