class Driver < ApplicationRecord
  include Driver::DriverStatus

  belongs_to :user
  acts_as_tenant :organization

  belongs_to :delivery_order
end
