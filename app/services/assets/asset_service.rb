module Assets
  class AssetService
    attr_reader :params
    attr_accessor :success, :errors, :asset, :assets

    def initialize(params = {})
      @params = params
      @success = false
      @errors = []
    end

    def execute_create_asset
      handle_asset_creation
      self
    end

    def execte_fetch_assets
      handle_fetch_asset
      self
    end

    def execute_delete_asset
      handle_asset_deletion
      self
    end

    def execute_edit_asset
      handle_asset_edit
      self
    end

    def success?
      @success || @errors.empty?
    end

    def errors
      @errors.join(", ")
    end

    private

    def handle_asset_creation
      begin
        if user.present? && user.admin?
          @asset = Asset.new(asset_params.merge(user_id: user.id))
          if @asset.save!
            @success = true
            @errors = []
          else
            @success = false
            @errors = @asset.errors.full_messages
          end
        else
          @success = false
          @errors << "You are not authorized to perform this action"
        end
      rescue ActiveRecord::RecordInvalid => err
        @success = false
        @errors << err.message
      end
    end

    def handle_asset_deletion
      begin
        @asset = Asset.find_by!(id: params[:id])
        if @asset && user.present? && user.admin?
            if @asset.destroy
              @success = true
              @errors = []
            else
              @success = false
              @errors = @asset.errors.full_messages

            end
        else
          @success = false
          @errors << "You are not authorized to perform this action"
        end
      rescue ActiveRecord::RecordNotDestroyed => err
        @success = false
        @errors << err.message
      end
    end

    def handle_asset_edit
      begin
        @asset = Asset.find_by!(id: params[:id])
        if user.present? && user.admin?
          if @asset.update!(asset_params.except(:asset_id))
            @success = true
            @errors = []
          else
            @success = false
            @errors  = @asset.errors.full_messages
          end
        else
          @success = false
          @errors << "You are not authorized to perform this action"
        end
      rescue ActiveRecord::RecordInvalid => err
          @success = false
          @errors << err.message
      end
    end

    def handle_fetch_asset
      begin
        @assets = Asset.order(created_at: :DESC)
        if @assets.empty?
          @success = true
          @errors << "No asset created yet"
        else
          @success = true
          @errors = []
        end
      rescue ActiveRecord::ActiveRecordError => err
        @success = false
        @errors << err.message
      end
    end

    def user
      current_user = params[:current_user]
      @user ||= current_user
    end

    def asset_params
      ActionController::Parameters.new(params).permit(:asset_id, :asset_category, :asset_status)
    end
  end
end
