class Driver < ApplicationRecord
  include Driver::DriverStatus

  belongs_to :user
  acts_as_tenant :organization

  has_many :delivery_orders, dependent: :nullify
end
