# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [ Types::NodeType, null: true ], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ ID ], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :get_customers, description: "Resolvers for getting organization customers", resolver: Resolvers::Customers::GetCustomers
    field :get_customer_branch, description: "Resolvers for getting customer branches", resolver: Resolvers::CustomersBranch::GetCustomerBranch
    field :get_assets, description: "Resolver for fetching Organization assets", resolver: Resolvers::Assets::GetAssets
    field :find_products, description: "Resovler for the product fetching", resolver: Resolvers::Products::ProductResolver
    field :get_drivers, description: "Resolver for fetching Organization drivers", resolver: Resolvers::Drivers::GetDrivers
    field :get_orders, description: "Resolver for fetching the orders", resolver: Resolvers::Orders::GetOrders
    field :get_categories, description: "Resolver for fetching thr orders", resolver: Resolvers::Categories::GetCategory
  end
end
