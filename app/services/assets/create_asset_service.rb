module Assets
  class CreateAssetService
    def initilize(asset_params)
      @asset_params = asset_params
    end

    def call
      asset = Asset.new(@asset_params)
      if asset.save
        [ asset, [] ]
      else
        [ nil, asset.errors.full_messages ]
      end
     rescue StandardError => e
      [ nil, [ e.message ] ]
    end
  end
end
