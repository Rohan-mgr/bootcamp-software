class CustomerBranch < ApplicationRecord
  belongs_to :customer

  has_many :delivery_orders, dependent: :destroy
end
