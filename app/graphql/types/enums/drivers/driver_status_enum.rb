module Types
  module Enums
    module Drivers
      class DriverStatusEnum < BaseEnum
        ::Driver::DriverStatus::STATUS.each do |name, value|
          value(name, value)
        end
      end
    end
  end
end
