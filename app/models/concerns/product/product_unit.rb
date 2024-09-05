module Product::ProductUnit
  extend ActiveSupport::Concern

  UNITS = { liters: "Liters", gallons: "Gallons" }.freeze
  included do
    enum product_unit: UNITS
  end
end
