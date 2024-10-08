module Users
  class SessionService
    attr_reader :params
    attr_accessor :success, :errors, :token, :user

    def initialize(params = {})
      @params = params
      @success = false
      @errors = []
    end

    def execute
      handle_user_sign_in
      self
    end

    def execute_user_signout(current_user)
      handle_user_signout(current_user)
      self
    end

    def success?
      @success || @errors.empty?
    end

    def errors
      @errors.join(", ")
    end

    private

    def handle_user_sign_in
      begin
        @user = User.find_for_authentication(email: params[:email])
        if user&.valid_password?(params[:password])
          @token = @user.generate_jwt
          @user = @user
          @success = true
          @errors = false
        else
          @success = false
          @errors << "Invalid email or password!"
        end
      rescue ActiveRecord::RecordNotFound => err
        @success = false
        @errors = err.message
      end
    end

    def handle_user_signout(current_user)
      begin
        if current_user
          if current_user.update(jti: SecureRandom.uuid)
            @success = true
            @errors = []
          else
            @success = false
            @errors = current_user.errors.full_messages
          end
        else
          @success = false
          @errors << "Failed to logout! User not found."
        end
      rescue StandardError => e
        @success = false
        @errors << "An error occurred while logging out: #{e.message}"
      end
    end
  end
end
