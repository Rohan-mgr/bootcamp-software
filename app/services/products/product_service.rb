module Products
  class ProductService
    attr_reader :params
    attr_accessor :success, :errors, :product, :products

    def initialize(params = {})
      @params = params
      @success = false
      @errors = []
    end

    def execute_find_product
      find_products
      self
    end

    def execute_create_product
      create_product
      self
    end

    def execute_update_product
      update_product
      self
    end

    def execute_delete_product
      delete_product
      self
    end

    def success?
      @success || @errors.empty?
    end

    def errors
      @errors.join(", ")
    end

    def products
      @products || []
    end

    private
    def find_products
      begin
        @products = Product.all.reverse
        if @products.empty?
          @success = true
          @errors << "No product created yet"
        else
          @success = true
          @errors = []
        end
      end

    rescue ActiveRecord::Rollback => err
          @success = false
          @errors << err.message
    end

    def create_product
      begin
        @product = Product.new(product_params.merge(user_id: current_user.id))
        if @product.save!
          @success = true
          @errors = []
        else
          @success = false
          @errors << "Failed to create product"
        end

      rescue ActiveRecord::RecordInvalid => err
        @success = false
        @errors << err.message
      rescue ActiveRecord::RecordNotFound => err
        @success = false
        @errors << err.message
      end
    end

    def update_product
      begin
       @product = Product.find(params[:id])
        if current_user.admin?
          if @product.update!(product_params)
            @success = true
            @errors = []
          else
            @success = false
            @errors = @product.errors.full_messages
          end
        else
          @success = false
          @errors = [ "Sorry! You do not have permission to update this product." ]
        end

      rescue ActiveRecord::RecordInvalid => err
        @success = false
        @errors << err.message
      rescue ActiveRecord::RecordNotFound => err
        @success = false
        @errors << err.message
      end
    end

    def delete_product
      begin
         @product = Product.find(params[:id])
        if current_user.admin?
          if @product.destroy!
            @success = true
            @errors = []
          else
            @success = false
            @errors = @product.errors.full_messages
          end
        else
          @success = false
          @errorrs = [ "Sorry! You dont have permission to delete the product." ]
        end

      rescue ActiveRecord::RecordNotFound => err
        @success = false
        @errors << err.message
      end
    end

    def current_user
      current_user = params[:current_user]
      @current_user ||= current_user
    end

    def product_params
      ActionController::Parameters.new(params).permit(:name, :product_category, :product_status, :product_unit)
    end
  end
end
