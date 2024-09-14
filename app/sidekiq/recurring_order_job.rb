class RecurringOrderJob
  include Sidekiq::Job

  def perform(order_group_id)
    order_group = OrderGroup.find(order_group_id)
    return unless order_group.recurring?

    frequency = order_group.recurring["frequency"]
    start_date = Date.parse(order_group.recurring["started_at"])
    end_date = Date.parse(order_group.recurring["end_at"])
    current_date = start_date

    while current_date <= end_date
      create_recurring_order(order_group, current_date)
      current_date = calculate_next_date(current_date, frequency)
    end
  end

  private

  def create_recurring_order(original_order, scheduled_date)
    new_order = original_order.dup
    new_order.started_at = scheduled_date
    new_order.created_at = scheduled_date
    new_order.updated_at = scheduled_date
    new_order.status = "pending"

    new_delivery_order = original_order.delivery_order.dup
    new_delivery_order.planned_at = scheduled_date
    new_delivery_order.created_at = scheduled_date
    new_delivery_order.updated_at = scheduled_date

    new_order.delivery_order = new_delivery_order
    original_order.delivery_order.line_items.each do |item|
      new_delivery_order.line_items << item.dup
    end
    new_order.save!
  end

  def calculate_next_date(current_date, frequency)
    current_date = Date.parse(current_date.to_s) unless current_date.is_a?(Date)

    case frequency.to_sym
    when :daily
      current_date.next_day
    when :every_week
      current_date.next_week
    when :every_month
      current_date.next_month
    else
      raise ArgumentError, "Invalid frequency: #{frequency}"
    end
  end
end
