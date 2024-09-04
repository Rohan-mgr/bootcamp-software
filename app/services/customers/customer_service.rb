module Customers
  class CustomerService
    attr_reader :params
    attr_accessor :success, :errors, :customer, :customers

    def initialize(params = {})
      @params = params
      @success = false
      @errors = []
    end

    def execute_create_customer
      handle_create_customer
      self
    end

    def execute_fetch_customers
      handle_fetch_customers
      self
    end

    def success?
      @success || @errors.empty?
    end

    def errors
      @errors.join(", ")
    end

    private

    def handle_create_customer
      ActiveRecord::Base.transaction do
        if organization.present?
          @customer = Customer.new(customer_params)
          if @customer.save!
            @customer.memberships.create!(organization: organization)

            @success = true
            @errors = []
          end
        else
        @success = false
        @errors << "Organzation not found!"
        end
      end

    rescue ActiveRecord::Rollback => err
      @success = false
      @errors << err.message
    end

    def handle_fetch_customers
      begin
        @customers = ActsAsTenant.current_tenant.customers.order(created_at: :DESC)
        if @customers.empty?
          @success = false
          @errors << "No customers found"
        else
          @success = true
          @errors = []
        end
      end

    rescue ActiveRecord::ActiveRecordError => err
      @success = false
      @errors = [ err.message ]
    end

    def organization
      organization ||= Organization.find_by(id: ActsAsTenant.current_tenant.id)
    end

    def customer_params
      ActionController::Parameters.new(params).permit(:name)
    end
  end
end
