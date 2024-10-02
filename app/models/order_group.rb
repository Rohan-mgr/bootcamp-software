class OrderGroup < ApplicationRecord
  include Order::OrderStatus
  acts_as_paranoid paranoid_destroy_dependencies: [ :delivery_order ]
  scope :recurring_orders, -> { where.not(parent_order_id: nil, recurring: nil).order(created_at: :DESC) }

  belongs_to :customer, -> { with_deleted }
  acts_as_tenant :organization

  has_one :delivery_order, -> { with_deleted }, dependent: :destroy
  accepts_nested_attributes_for :delivery_order, allow_destroy: true

  belongs_to :user

  def update_with_delivery_order(params)
    transaction do
      if self.delivery_order.present?
        self.delivery_order.destroy_fully!
      end
      self.create_delivery_order(params[:delivery_order_attributes])
      self.update!(params.except(:delivery_order_attributes))
    end
  end

  def set_recurring_details(recurring_details = nil)
    self.recurring = recurring_details
  end
end
