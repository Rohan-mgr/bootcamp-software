class Customer < ApplicationRecord
  has_many :memberships
  has_many :organization, through: :memberships

  has_many :customer_branches, dependent: :destroy
end
