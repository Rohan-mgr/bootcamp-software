class Product < ApplicationRecord
  include Product::ProductCategory
  include Product::ProductStatus
  include Product::ProductUnit
end
