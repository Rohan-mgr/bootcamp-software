class Product < ApplicationRecord
  include Product::ProductStatus
  include Product::ProductUnit

  belongs_to :user
  acts_as_tenant :organization
end
