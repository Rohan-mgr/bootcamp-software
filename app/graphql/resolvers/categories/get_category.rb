module Resolvers
  module Categories
    class GetCategory < Resolvers::BaseResolver
      type Types::Categories::CategoryResponseType, null: true

      argument :category_class, String, required: true

        def resolve(category_class:)
          begin
            category_service = ::Categories::CategoryService.new({ category_class: category_class }.to_h).excecute_get_category
            if category_service.success?
              {
                categories: category_service.categories,
                errors: []
              }
            else
              {
                categories: nil,
                errors: [ category_service.errors ]
              }
            end
          end
        rescue GraphQL::ExecutionError => err
          {
            customers: nil,
            errors: [ err.message ]
          }
        end
    end
  end
end
