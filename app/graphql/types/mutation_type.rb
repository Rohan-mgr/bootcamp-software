# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
   field :create_user, description: "Mutation for creating users", mutation: Mutations::Users::CreateUser
   field :user_session, description: "Mutation for user sign in", mutation: Mutations::Users::UserLogin
   field :user_logout, description: "Mutation for user sign out", mutation: Mutations::Users::UserLogout
   field :create_customer, description: "Mutation for creating customer", mutation: Mutations::Customers::CreateCustomer
  end
end
