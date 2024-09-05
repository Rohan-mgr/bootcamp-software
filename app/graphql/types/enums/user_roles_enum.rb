module Types
  module Enums
    class UserRolesEnum < BaseEnum
      ::UserRolesEnum::ROLES.each do |name, value|
        value(name, value)
      end
    end
  end
end
