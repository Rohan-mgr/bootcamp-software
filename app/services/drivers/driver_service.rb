module Drivers
  class DriverService
    attr_reader :params
    attr_accessor :success, :errors, :driver

    def initialize(params = {})
      @params = params
      @success = false
      @errors = []
    end

    def execute_create_driver
      handle_driver_creation
      self
    end

    def execute_delete_driver
      handle_driver_deletion
      self
    end

    def execute_edit_driver
      handle_driver_edit
      self
    end

    def success?
      @success || @errors.empty?
    end

    def errors
      @errors.join(", ")
    end

      private

      def handle_driver_creation
        if user.present? && user.admin?
          @driver = Driver.new(driver_params.merge(user_id: user.id))
            if @driver.save!
              @success = true
              @errors = []
            else
              @success = false
              @errors = @driver.errors.full_messages
            end
        else
            @success = false
            @errors << "You are not authorized to perform this action"
        end
      rescue ActiveRecord::Rollback, ActiveRecord::RecordInvalid => err
        @success = false
        @errors << err.message
      end

    def handle_driver_deletion
        ActiveRecord::Base.transaction do
          @driver = Driver.find_by!(id: params[:id])
          if @driver && user.present? && user.admin?
              if @driver.destroy
                @success = true
                @errors = []
              else
                @success = false
                @errors = @driver.errors.full_messages

              end
          else
            @success = false
            @errors << "You are not authorized to perform this action"
          end
        rescue  ActiveRecord::RecordNotFound => err
          @success = false
          @errors << "Driver not found"
        rescue ActiveRecord::RecordNotDestroyed => err
          @success = false
          @errors << err.message
        end
    end

    def handle_driver_edit
      ActiveRecord::Base.transaction do
        @driver = Driver.find_by!(id: params[:id])
        if user.present? && user.admin?
          if @driver.update!(driver_params)
            @success = true
            @errors = []
          else
            @success = false
            @errors  = @driver.errors.full_messages
          end
        else
          @success = false
          @errors << "You are not authorized to perform this action"
        end
      rescue ActiveRecord::RecordNotFound => err
        @success = false
        @errors = [ "Driver not found" ]
      rescue ActiveRecord::RecordInvalid => err
        @success = false
        @errors = [ err.message ]
      end
    end
    def user
      current_user = params[:current_user]
      @user ||= current_user
    end

    def driver_params
      # Sanitize input using strong parameters approach
      ActionController::Parameters.new(params).permit(:name, :phone, :email, :status)
    end
  end
end
