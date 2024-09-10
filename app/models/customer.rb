class Customer < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :organization, through: :memberships

  has_many :customer_branches, dependent: :destroy
  has_many :order_groups, dependent: :destroy
end
