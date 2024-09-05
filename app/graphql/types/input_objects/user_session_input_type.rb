module Types
  module InputObjects
    class UserSessionInputType < BaseInputObject
      argument :email, String, required: true
      argument :password, String, required: true
    end
  end
end
