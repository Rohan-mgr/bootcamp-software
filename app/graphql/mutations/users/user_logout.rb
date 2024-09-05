module Mutations
  module Users
    class UserLogout < BaseMutation
      field :message, String, null: false
      field :errors, [ String ], null: true

      def resolve
        begin
          user_session_service = ::Users::SessionService.new.execute_user_signout(context[:current_user])
          if user_session_service.success?
            {
              message: "User logout successfully",
              errors: []
            }
          else
            {
              message: "Failed to logout!",
              errors: [ user_session_service.errors ]
            }
          end
        rescue StandardError, GraphQL::ExecutionError => err
          {
            message: "Failed to logout!",
            errors: [ err.message ]
          }
        end
      end
    end
  end
end
