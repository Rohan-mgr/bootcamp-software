module Products
  class ProductService
    attr_reader :params
    attr_accessor :success, :errors

    def initialize
      @params = params
      @success = false
      @errors = []
    end

    def execute
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
      ActiveRecord::Base.transaction do
        @products = Product.all.reverse

        @success = true
        @errors = []
      end

    rescue ActiveRecord::Rollback => err
          @success = false
          @errors << err.message
    end

    def create_product
      ActiveRecord::Base.transaction do
        @product = Product.new(product_params)
        @product.save!

        @success = true
        @errors = []
      end

    rescue ActiveRecord::RecordInvalid => err
        @success = false
        @errors << err.message
    rescue ActiveRecord::RecordNotFound => err
        @success = false
        @errors << err.message
    end

    def update_product
      ActiveRecord::Base.transaction do
       @product = Product.find(params[:id])
       @product.update!(product_params)

       @success = true
       @errors = []
      end

    rescue ActiveRecord::RecordInvalid => err
      @success = false
      @errors << err.message
    rescue ActiveRecord::RecordNotFound => err
      @success = false
      @errors << err.message
    end

    def delete_product
      begin
        @product = Product.find(params[:id])
        @product.destroy!

        @success = true
        @errors = []
      rescue ActiveRecord::RecordNotFound => err
        @success = false
        @errors << err.message
      end
    end

    def product_params
      params.require(:product).permit(:name, :product_category, :product_status, :product_unit)
    end
  end
end
