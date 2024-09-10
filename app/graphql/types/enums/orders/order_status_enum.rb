module Types
  module Enums
    module Orders
      class OrderStatusEnum < BaseEnum
        ::Order::OrderStatus::STATUS.each do |name, value|
          value(name, value)
        end
      end
    end
  end
end
