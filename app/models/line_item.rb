class LineItem < ApplicationRecord
  acts_as_paranoid
  belongs_to :delivery_order
end
