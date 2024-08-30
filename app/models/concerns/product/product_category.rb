module Product::ProductCategory
  extend ActiveSupport::Concern

  included do
      enum product_category: { petrol: "petrol", diesel: "diesel", luburicants: "lubricants", lpg: "LPG" }
  end
end
