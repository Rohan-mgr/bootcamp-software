module Product::ProductStatus
  extend ActiveSupport::Concern
  STATUS = { available: "Available", out_of_stock: "Out of Stock" }.freeze
  included do
    enum product_status: STATUS
  end
end
