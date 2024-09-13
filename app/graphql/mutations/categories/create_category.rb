module Mutations
  module Categories
    class CreateCategory < Mutations::BaseMutation
      argument :category_info, Types::InputObjects::CategoryInputType, required: true

      field :category, Types::Categories::CategoryType, null: false
      field :errors, [ String ], null: false

      def resolve(category_info: {})
        begin
          category_service = ::Categories::CategoryService.new(category_info.to_h.merge(current_user: context[:current_user])).execute_create_category

          if category_service.success?
            {
              category: category_service.category,
              errors: []
            }
          else
            {
              category: nil,
              errors: [ category_service.errors ]
            }

          end
        end
      rescue  GraphQL::ExecutionError => e
        {
          category: nil,
          errors: [ e.message ]
        }
      end
    end
  end
end
