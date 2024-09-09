module Driver::DriverStatus
  extend ActiveSupport::Concern
   STATUS = {
     active: "active",
     inactive: "inactive"
   }.freeze

   included do
     enum status: STATUS
   end
end
