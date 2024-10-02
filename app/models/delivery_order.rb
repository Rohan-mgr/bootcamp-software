class DeliveryOrder < ApplicationRecord
  acts_as_paranoid paranoid_destroy_dependencies: [ :line_items ]
  belongs_to :customer_branch, -> { with_deleted }
  belongs_to :asset, optional: true

  belongs_to :order_group
  has_many :line_items, -> { with_deleted }, dependent: :destroy
  accepts_nested_attributes_for :line_items, allow_destroy: true

  belongs_to :driver, optional: true
end
