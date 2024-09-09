module Types
  module Drivers
    class DriverResponseType < BaseObject
      field :drivers, [ Types::Drivers::DriverType ], null: true
      field :errors, [ String ], null: true
    end
  end
end
