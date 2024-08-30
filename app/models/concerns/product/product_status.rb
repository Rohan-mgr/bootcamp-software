module Product::ProductStatus
  extend ActiveSupport::Concern

  included do
    enum product_status: { available: "Available", out_of_stock: "Out of Stock" }
  end
end
