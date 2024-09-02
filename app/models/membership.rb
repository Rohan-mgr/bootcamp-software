class Membership < ApplicationRecord
  belongs_to :user
  acts_as_tenant :organization
end
