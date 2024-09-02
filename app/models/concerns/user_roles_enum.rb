module UserRolesEnum
  extend ActiveSupport::Concern

   ROLES = {
    admin: "admin",
    member: "member",
    superadmin: "superadmin"
  }.freeze

  included do
    enum roles: ROLES
  end
end
