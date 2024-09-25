module Mutations
  module Categories
    class DeleteCategory < Mutations::BaseMutation
      argument :id, ID, required: true

      field :category, Types::Categories::CategoryType, null: false
      field :message, String, null: false
      field :errors, [ String ], null: false

      def resolve(id:)
        begin
          category_service = ::Categories::CategoryService.new({ id: id }.to_h.merge(current_user: context[:current_user])).execute_delete_category
          if category_service.success?
            {
              category: category_service.category,
              message: "Category deleted successfully",
              errors: []
            }
          else
            raise category_service.errors
          end
        end
      rescue GraphQL::ExecutionError =>e
        {
          category: nil,
          message: "Failed to delete category",
          errors: [ e.message ]
        }
      end
    end
  end
end
