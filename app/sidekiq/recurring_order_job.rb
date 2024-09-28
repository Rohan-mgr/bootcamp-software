class RecurringOrderJob
  include Sidekiq::Job

  def perform(order_group_id, organization_id)
    ActsAsTenant.with_tenant(Organization.find(organization_id)) do
      ::Orders::RecurringOrderService.new(order_group_id).execute_recurring_order_creation
    end
  end
end
