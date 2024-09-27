class RecurringOrderJob
  include Sidekiq::Job

  def perform(order_group_id)
    ::Orders::RecurringOrderService.new(order_group_id).execute_recurring_order_creation
  end
end
