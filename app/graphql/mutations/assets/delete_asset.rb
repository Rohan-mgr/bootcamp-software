module Mutations
  module Assets
    class DeleteAsset < Mutations::BaseMutation
      argument :id, ID, required: true
      field :message, String, null: false
      field :errors, [ String ], null: false

      def resolve(id:)
        unless context[:create_user]&.admin?
        raise GraphQL::ExecutionError, "You are not authorized to  perform this action"
        end

        service = ::Assets::DeleteAssetService.new(id)
        message, errors = service.call
        
            {
              message: message,
              errors: errors
            }

        rescue GraphQL::ExecutionError => err
            {
              message: "Failed to delete assets",
              errors: [ err.message ]
            }
      end
    end
  end
end
