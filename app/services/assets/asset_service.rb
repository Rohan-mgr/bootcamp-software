module Assets
  class AssetService
    attr_reader :params
    attr_accessor :success, :errors, :asset

    def initialize(params = {})
      @params = params
      @success = false
      @errors = []
    end

    def execute_create_asset
      handle_asset_creation
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
    rescue ActiveRecord::Rollback, ActiveRecord::RecordInvalid => err
      @success = false
      @errors << err.message
    end

    def handle_asset_deletion
      ActiveRecord::Base.transaction do
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
      ActiveRecord::Base.transaction do
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

    def user
      current_user = params[:current_user]
      @user ||= current_user
    end

    def asset_params
      # Sanitize input using strong parameters approach
      ActionController::Parameters.new(params).permit(:asset_id, :asset_category, :asset_status)
    end
  end
end
