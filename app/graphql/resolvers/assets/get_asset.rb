module Resolvers
  module Blogs
    class GetAsset < BaseResolver
      type [ Types::Assets::AssetType ], null: true
    end
  end
end
