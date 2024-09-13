module Categories
  class CategoryService
    attr_reader :params
    attr_accessor :success, :errors, :category, :categories

    def initialize(params = {})
      @params = params
      @success = false
      @errors = []
    end

    def excecute_get_category
      handle_get_categories
      self
    end

    def execute_create_category
      handle_category_creation
      self
    end

    def execute_delete_category
      handle_category_deletion
      self
    end

    def execute_edit_category
      handle_category_edit
      self
    end

    def success?
      @success || @errors.empty?
    end

    def errors
      @errors.join(", ")
    end

    private

    def handle_get_categories
      begin
        @categories = Category.order(created_at: :DESC).where([ "category_class = ?", params[:category_class].downcase ])
        if @categories.empty?
          @success = false
          @errors << "No categories found"
        else
          @success = true
          @errors = []
        end
      end

    rescue ActiveRecord::ActiveRecordError => err
      @success = false
      @errors = [ err.message ]
    end

    def handle_category_creation
      unless user.present? && user.admin?
        @success = false
        @errors = [ "You're not authorized to perform this action" ]
        return
      end

      @category = Category.new(category_params.merge(user_id: user.id))
      if @category.save!
        @success = true
        @errors = []
      else
        @success = false
        @errors << "Failed to create category"
      end
    rescue ActiveRecord::RecordInvalid => err
      @success = false
      @errors = [ err.message ]

    rescue ActiveRecord::RecordNotFound => err
      @success = false
      @errors = [ err.message ]
    end

    def handle_category_deletion
      @category = Category.find_by!(id: params[:id])

      if @category && user.present? && user.admin?
        if @category.destroy
          @success = true
          @errors = []
        else
          @success =false
          @errors = @category.errors.full_messages
        end
      else
        @success = false
        @errors << "You aren't allowed to peform this action"
      end
    rescue ActiveRecord::RecordNotDestroyed => err
      @success = false
      @errors = err.message
    end

    def handle_category_edit
      unless user.present? && user.admin?
        @success = false
        @errors = [ "You aren't authorized to perform this action" ]
        return
      end
      begin
        @category = Category.find_by!(id: params[:id])

        if @category.update(category_params.except(:category_class))
            @success = true
            @errors = []
        else
          @success = false
          @errors = @category.errors.full_messages
        end
      end
    rescue ActiveRecord::RecordNotFound => err
      @success = false
      @errors << "Category Not Found"
    rescue ActiveRecord::RecordInvalid => err
      @success = false
      @errors = [ err.message ]
    end

    def user
      user ||= params[:current_user]
    end

    def category_params
      ActionController::Parameters.new(params).permit(:name, :category_class)
    end
  end
end
