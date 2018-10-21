class ProductsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]

  def index
    @products = Product.all
    @product = @products.map do |product|
    end
  end

  def show
    @product = Product.find_by(id: params[:id])
    render_404 if @product.nil?
  end

  def new
    merchant = Merchant.find_by(id: params[:merchant_id])
    @product = merchant.products.new
  end

  def create
    filtered_product_params = product_params()
    @product = Product.new(filtered_product_params)

    is_successful_save = @product.save

    if is_successful_save
      flash[:success] = "Successfully created new product with title \"#{@product.name}\""
      redirect_to product_path(@product.id)
    else
      flash.now[:error] = "Invalid product data"
      render :new, status: :bad_request
    end
  end

  def edit
    @product = Product.find_by(id: params[:id])
    render_404 if @product.nil?
  end

  def update
    @product = Product.find_by(id: params[:id])
    if @product.update(product_params)
      flash[:success] = "Successfully updated product \"#{@product.name}\""
      redirect_to product_path(@product.id)
    else
      flash.now[:error] = "Invalid product data"
      render(:edit, status: :bad_request)
    end
  end

  private

  def product_params
    return params.require(:product).permit(
      :name,
      :price,
      :inventory,
      :merchant_id,
      :description,
      category_ids: [],
    )
  end
end
