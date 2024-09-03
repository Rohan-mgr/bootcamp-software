module Assets
  class EditAssetService
    def initialize (asset_id, asset_params)
      @asset_id = asset_id
      @asset_params = asset_params
    end

    def call
      asset = Asset.find_by(id: @asset_id)

      if asset.nil?
        [ nil, [ "Asset not found" ] ]
      elsif asset.update(@asset_params)
        [ asset, [] ]
      else
        [ nil, asset.errors.full_messages ]
      end
     rescue StandardError => e
      [ nil, [ e.message ] ]
    end
  end
end
