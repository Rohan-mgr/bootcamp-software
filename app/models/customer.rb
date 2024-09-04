class Customer < ApplicationRecord
  has_many :memberships
  has_many :organization, through: :memberships
end
