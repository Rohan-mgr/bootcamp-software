module Types
  module InputObjects
    class CustomerRegistrationInputType < BaseInputObject
      argument :name, String, required: true
    end
  end
end
