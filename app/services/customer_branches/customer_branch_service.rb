module CustomerBranches
  class CustomerBranchService
    attr_reader :params
    attr_accessor :success, :errors, :branch, :branches

    def initialize(params = _ { })
      @params = params
      @success = false
      @errors = []
    end

    def execute_branch_creation
      handle_create_customer_branch
      self
    end

    def execute_fetch_customer_branch
      handle_fetch_customer_branch
      self
    end

    def execute_branch_updation
      handle_update_customer_branch
      self
    end

    def execute_branch_deletion
      handle_delete_customer_branch
      self
    end

    def success?
      @success || @errors.empty?
    end

    def errors
      @errors.join(", ")
    end
    private

    def handle_create_customer_branch
      begin
        customer = Customer.find(params[:customer_id])

        if customer.present?
          @branch = CustomerBranch.create!(customer_branch_params)

          @success = true
          @errors = []
        else
          @success = true
          @errors << "Customer not found"
        end
      end

    rescue ActiveRecord::ActiveRecordError => err
      @success = false
      @errors << err.message
    end

    def handle_fetch_customer_branch
      begin
        customer = Customer.find(params[:id])
        if customer.present?
          @branches = customer.customer_branches
          @success = true
          @errors = []
        else
          @success = true
          @errors << "Customer not found"
        end
      end
    rescue ActiveRecord::ActiveRecordError => err
      @success = false
      @errors << err.message
    end

    def handle_update_customer_branch
      begin
        customer_branch = CustomerBranch.find(params[:id])
          if customer_branch.present?
            customer_branch.update!(customer_branch_params)
            @branch = customer_branch
            @success = true
            @errors = []
          else
            @success = true
            @errors << "Customer Branch not found"
          end
      rescue ActiveRecord::ActiveRecordError => err
        @success = false
        @errors = [ err.message ]
      end
    end

    def handle_delete_customer_branch
      begin
        customer_branch = CustomerBranch.find(params[:id])
        if current_user.admin?
          if customer_branch.destroy!
            @branch = customer_branch
            @success = true
            @errors = []
          else
            @success = false
            @errors = customer_branch.errors.full_messages
          end
        else
          @success = false
          @errors = [ "Sorry! You don't have permisssion to delete the customer branch. " ]
        end
      rescue ActiveRecord::ActiveRecordError => err
        @success = false
        @errors << err.message
      end
    end

    def current_user
      current_user = params[:current_user]
      @current_user ||= current_user
    end


    def customer_branch_params
      ActionController::Parameters.new(params).permit(:name, :location, :customer_id)
    end
  end
end
