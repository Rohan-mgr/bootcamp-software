module Types
  module Assets
    class AssetsResponseType < BaseObject
      field :assets, [ Types::Assets::AssetType ], null: true
      field :errors, [ String ], null: true
    end
  end
end
