module Product::ProductCategory
  extend ActiveSupport::Concern

  CATEGORY = { petrol: "petrol", diesel: "diesel", luburicants: "lubricants", lpg: "LPG" }.freeze
  included do
      enum product_category: CATEGORY
  end
end
