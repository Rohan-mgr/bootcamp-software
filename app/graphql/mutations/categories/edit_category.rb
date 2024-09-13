module Mutations
  module Categories
    class EditCategory < Mutations::BaseMutation
      argument :category_info, Types::InputObjects::CategoryInputType, required: true
      argument :id, ID, required: true


      field :category, Types::Categories::CategoryType, null: false
      # field :message, String, null: true
      field :errors, [ String ], null: false

      def resolve(id:, category_info: {})
        begin
          category_service = ::Categories::CategoryService.new(category_info.to_h.merge(id: id, current_user: context[:current_user])).execute_edit_category

          if category_service.success?
            {
              category: category_service.category,
              # message: "Category Edited Successfully",
              errors: []
            }
          else
            {
              category: nil,
              # message: "Failed to edit",
              errors: [ category_service.errors ]
            }
          end
        end
      rescue GraphQL::ExecutionError => err
        {
          category: nil,
          errors: [ err.message ]
        }
      end
    end
  end
end
