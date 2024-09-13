class Category < ApplicationRecord
  belongs_to :user
  acts_as_tenant :organization
end
