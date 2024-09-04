class Membership < ApplicationRecord
  belongs_to :customer
  acts_as_tenant :organization
end
