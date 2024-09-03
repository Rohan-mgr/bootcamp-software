module Assets
  class DeleteAssetService
    def initialize(asset_id)
      @asset_id = asset_id
    end

    def call
      asset = Asset.find_by(id: @asset_id)

      if asset.nil?
        [ nil, [ "Asset not found" ] ]
      elsif asset.destroy
        [ "Asset deleted successfully", [] ]
      else
        [ nil, asset.errors.full_messages ]
      end
     rescue StandardError => e
      [ nil, [ e.message ] ]
    end
  end
end
