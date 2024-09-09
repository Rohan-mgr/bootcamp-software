class Organization < ApplicationRecord
  has_many :users

  has_many :memberships
  has_many :customers, through: :memberships
  has_many :assets, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :drivers, dependent: :destroy
end
