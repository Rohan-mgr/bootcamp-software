module Types
  module InputObjects
    class CustomerRegistrationInputType < BaseInputObject
      argument :name, String, required: true
      argument :phone_no, String, required: true
      argument :email, String, required: true
      argument :zipcode, Integer, required: true
      argument :address, String, required: true
    end
  end
end
