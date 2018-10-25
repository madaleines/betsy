class ProductsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]

  def index
    merchant_params = params[:merchant_id]
    if merchant_params
      merchant = find_merchant
      @products = merchant.products
    else
      @products = Product.all
      @shopping_cart = find_shopping_cart
    end
  end

  def show
    @product = find_product
    render_404 if @product.nil?
  end

  def new
    @product = @current_merchant.products.new
  end

  def create
    @product = @current_merchant.products.new(product_params)
    is_successful_save = @product.save
    is_successful_save ? product_created : cannot_create_product
  end

  def edit
    @product = find_product
    render_404 if @product.nil?
  end

  def update
    @product = find_product
    is_successful_update = @product.update(product_params)
    is_successful_update ? updated_product : cannot_update_product
  end

  def change_status
    @product = find_product
    if @product.is_active == true
      @product.update(is_active: false)
    else
      @product.update(is_active: true)
    end

    redirect_to dashboard_path
    #
    # flash[:status] = "I'm product #{@product.id}, my status is: #{@product.is_active}"
    #
    # if @product.update(product_params)
    # end
  end


  private

  def cannot_update_product
    flash.now[:error] = "Invalid product data"
    render(:edit, status: :bad_request)
  end

  def updated_product
    flash[:success] = "Successfully updated product \"#{@product.name}\""
    redirect_to product_path(@product.id)
  end

  def cannot_create_product
    flash.now[:error] = "Invalid product data"

    flash[:error] = @product.errors.messages
    # @product.errors.each do |error|
    #   flash.now[:error] = error
    # end
    render :new, status: :bad_request
  end

  def product_created
    flash[:success] = "Successfully created new product with title \"#{@product.name}\""
    redirect_to product_path(@product.id)
  end

  def create_product(product_params)
    return Product.new(product_params)
  end

  def product_params
    return params.require(:product).permit(
      :name,
      :price,
      :inventory,
      :merchant_id,
      :description,
      :is_active,
      :image,
      category_ids: [],
    )
  end
end
