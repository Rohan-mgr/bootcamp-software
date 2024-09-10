module Order::OrderStatus
  extend ActiveSupport::Concern

  STATUS = { pending: "pending", completed: "completed", cancelled: "cancelled" }
  included do
    enum status: STATUS
  end
end
