class CustomerBranch < ApplicationRecord
  acts_as_paranoid

  belongs_to :customer

  has_many :delivery_orders, dependent: :destroy
end
