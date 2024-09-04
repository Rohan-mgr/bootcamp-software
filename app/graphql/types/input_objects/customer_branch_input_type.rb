module Types
  module InputObjects
    class CustomerBranchInputType < BaseInputObject
      argument :name, String, required: true
      argument :location, String, required: true
      argument :customer_id, ID, required: true
    end
  end
end
