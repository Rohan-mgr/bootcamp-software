module Orders
  class OrderService
    attr_reader :params
    attr_accessor :success, :errors, :orders

    def initialize(params = {})
      @params = params
      @success = false
      @errors = []
    end

    def execute_order_creation
      handle_create_order
      self
    end

    def execute_fetch_orders
      handle_fetch_orders
      self
    end

    def success?
      @success || @errors.empty?
    end

    def errors
      @errors.join(", ")
    end

    private

    def handle_create_order
      ActiveRecord::Base.transaction do
        order_group = OrderGroup.new(order_params)
        if order_group.save!
          @success = true
          @errors = []
        else
          @success = false
          @errors << order_group.errors.full_messages
        end
      end

    rescue ActiveRecord::Rollback => err
      @success = false
      @errors << err.message
    end

    def handle_fetch_orders
      begin
        order_group = OrderGroup.includes(delivery_order: :line_items).order(created_at: :DESC)
        if order_group.empty?
          @success = false
          @errors << "No orders created yet"
        else
          @success = true
          @errors = []
          @orders = order_group.as_json(include: { delivery_order: { include: :line_items } })
        end
      end
    rescue ActiveRecord::ActiveRecordError => err
      @success = false
      @errors << err.message
    end

    def order_params
      ActionController::Parameters.new(params).permit(:status, :started_at, :completed_at, :customer_id,
        delivery_order_attributes: [ :planned_at, :status, :completed_at, :customer_branch_id, :asset_id,
          line_items_attributes: [ :name, :quantity, :units ]
        ]
      )
    end
  end
end
