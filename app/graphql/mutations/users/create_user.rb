module Mutations
  module Users
    class CreateUser < BaseMutation
      argument :user_info, Types::InputObjects::UserRegistrationInputType, required: true

      field :message, String, null: true
      field :errors, [ String ], null: true

      def resolve(user_info: {})
        begin
          registration_service = ::Users::RegistrationService.new(user_info.to_h).execute
          if registration_service.success?
            {
              message: "User registered successfully",
              errors: []
            }
          end

        rescue StandardError => err
          {
            message: "User Registration Failed!",
            errors: [ err.message ]
          }
        end
      end
    end
  end
end
