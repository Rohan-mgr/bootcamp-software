class RecurringOrderJob
  include Sidekiq::Job

  def perform(order_group_id, scheduled_date = nil)
    order_group = OrderGroup.find(order_group_id)
    return unless order_group.recurring?

    if scheduled_date.nil?
      schedule_recurring_orders(order_group)
    else
      create_recurring_order(order_group, scheduled_date)
      schedule_next_order(order_group, scheduled_date)
    end
  end

  private

  def schedule_recurring_orders(order_group)
    frequency = order_group.recurring["frequency"]
    start_date = Date.parse(order_group.recurring["started_at"])
    end_date = Date.parse(order_group.recurring["end_at"])
    current_date = start_date

    while current_date <= end_date
      RecurringOrderJob.perform_at(current_date.to_time, order_group.id, current_date.to_s)
      current_date = calculate_next_date(current_date, frequency)
    end
  end

  def create_recurring_order(original_order, scheduled_date)
    new_order = original_order.dup
    new_order.started_at = scheduled_date
    new_order.status = "pending"

    new_delivery_order = original_order.delivery_order.dup
    new_delivery_order.planned_at = scheduled_date
    new_delivery_order.status = "pending"

    new_order.delivery_order = new_delivery_order

    original_order.delivery_order.line_items.each do |item|
      new_delivery_order.line_items << item.dup
    end

    new_order.save!
  end

  def schedule_next_order(order_group, current_date)
    frequency = order_group.recurring["frequency"]
    end_date = Date.parse(order_group.recurring["end_at"])
    next_date = calculate_next_date(Date.parse(current_date), frequency)

    if next_date <= end_date
      RecurringOrderJob.perform_at(next_date.to_time, order_group.id, next_date.to_s)
    end
  end

  def calculate_next_date(current_date, frequency)
    case frequency.to_sym
    when :daily
      current_date.next_day
    when :weekly
      current_date.next_week
    when :monthly
      current_date.next_month
    else
      raise ArgumentError, "Invalid frequency: #{frequency}"
    end
  end
end
