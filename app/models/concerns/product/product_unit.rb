module Product::ProductUnit
  extend ActiveSupport::Concern

  included do
    enum product_unit: { liters: "Liters", gallons: "Gallons" }
  end
end
