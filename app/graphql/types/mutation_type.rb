# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
   field :delete_product, description: "Mutations for deleting products", mutation: Mutations::Products::DeleteProduct
   field :update_product, description: "Mutation for updating products", mutation: Mutations::Products::UpdateProduct
   field :create_product, description: "Mutation for creating products", mutation: Mutations::Products::CreateProduct
   field :create_user, description: "Mutation for creating users", mutation: Mutations::Users::CreateUser
   field :user_session, description: "Mutation for user sign in", mutation: Mutations::Users::UserLogin
   field :user_logout, description: "Mutation for user sign out", mutation: Mutations::Users::UserLogout
   field :create_customer_branch, description: "Mutation for creating customer branch", mutation: Mutations::CustomersBranch::CreateCustomerBranch
   field :update_customer_branch, description: "Mutations for updating customer branch", mutation: Mutations::CustomersBranch::UpdateCustomerBranch
   field :delete_customer_branch, description: "Mutations for deleting customer branch", mutation: Mutations::CustomersBranch::DeleteCustomerBranch
   field :create_asset, description: "Mutation for creating asset", mutation: Mutations::Assets::CreateAsset
   field :delete_asset, description: "Mutation for deleting asset", mutation: Mutations::Assets::DeleteAsset
   field :edit_asset, description: "Mutation for editing asset", mutation: Mutations::Assets::EditAsset
   field :create_driver, description: "Mutation for creating driver", mutation: Mutations::Drivers::CreateDriver
   field :delete_driver, description: "Mutation for deleting driver", mutation: Mutations::Drivers::DeleteDriver
   field :edit_driver, description: "Mutation for Editing driver", mutation: Mutations::Drivers::EditDriver
   field :create_order, description: "Mutation for creating orders", mutation: Mutations::Orders::CreateOrder
   field :delete_order, description: "Mutation for deleting order", mutation: Mutations::Orders::DeleteOrder
   field :edit_order, description: "Mutation for editing the order", mutation: Mutations::Orders::UpdateOrder
   field :create_customer, description: "Mutation for creating customer", mutation: Mutations::Customers::CreateCustomer
   field :update_customer, description: "Mutation for updating customer", mutation: Mutations::Customers::UpdateCustomer
   field :delete_customer, description: "Mutation for deleting customer", mutation: Mutations::Customers::DeleteCustomer
   field :create_category, description: "Mutation for creating category", mutation: Mutations::Categories::CreateCategory
   field :delete_category, description: "Mutation for deleting category", mutation: Mutations::Categories::DeleteCategory
   field :edit_category, description: "Mutation for editing category", mutation: Mutations::Categories::EditCategory
   field :upload_order, description: "Mutation for uploading order from csv file", mutation: Mutations::Orders::OrderCsvUpload
  end
end
