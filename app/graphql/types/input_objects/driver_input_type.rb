module Types
  module InputObjects
    class DriverInputType < BaseInputObject
      argument :id, ID, required: false
      argument :name, String, required: true
      argument :phone, String, required: true
      argument :email, String, required: true
      argument :status, Enums::Drivers::DriverStatusEnum, required: true
    end
  end
end
