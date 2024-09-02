module Mutations
  module Users
    class UserLogin < BaseMutation
      argument :session_info, Types::InputObjects::UserSessionInputType, required: true

      field :user, Types::Users::UserType, null: true
      field :token, String, null: true
      field :errors, [ String ], null: true

      def resolve(session_info: {})
        begin
          user_session_service = ::Users::SessionService.new(session_info.to_h).execute

          if user_session_service.success?
            {
              user: user_session_service.user,
              token: user_session_service.token,
              errors: []
            }
          else
            {
              errors: [ user_session_service.errors ]
            }
          end
        rescue StandardError, GraphQL::Execution::Errors => err
          {
            errors: [ err.message ]
          }
        end
      end
    end
  end
end
