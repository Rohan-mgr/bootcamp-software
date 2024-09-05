class Organization < ApplicationRecord
  has_many :users

  has_many :memberships
  has_many :customers, through: :memberships
  has_many :assets, dependent: :destroy
end
