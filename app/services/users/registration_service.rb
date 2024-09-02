module Users
  class RegistrationService
    attr_reader :params
    attr_accessor :success, :errors

    def initialize(params = {})
      @params = params
      @success = false
      @errors = []
    end

    def execute
      handle_user_registration
      self
    end

    def success?
      @success || @errors.empty?
    end

    def errors
      @errors.join(", ")
    end

    private

    def handle_user_registration
      ActiveRecord::Base.transaction do
        ActsAsTenant.without_tenant do
          @user = User.new(sign_up_params)
          if @user.save!
            Membership.create!(user_id: @user.id, organization_id: organization.id) if organization.present?
          end
          @success = true
          @errors = []
        end
      end

    rescue ActiveRecord::Rollback => err
      @success = false
      @errors << err.message
    end

    def organization
      organization ||= Organization.find_by(id: params[:organization_id])
    end

    def sign_up_params
      ActionController::Parameters.new(params).permit(:name, :email, :password, :password_confirmation, :roles)
    end
  end
end
