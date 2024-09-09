class Driver < ApplicationRecord
  include Driver::DriverStatus

  belongs_to :user
  acts_as_tenant :organization
end
