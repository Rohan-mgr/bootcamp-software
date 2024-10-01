class Customer < ApplicationRecord
  acts_as_paranoid

  has_many :memberships, dependent: :destroy
  has_many :organization, through: :memberships

  has_many :customer_branches, dependent: :destroy
  has_many :order_groups

  before_destroy :destroy_incomplete_order_groups

  private

  def destroy_incomplete_order_groups
    order_groups.where.not(status: :completed).destroy_all
  end
end
