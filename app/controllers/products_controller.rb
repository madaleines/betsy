class ProductsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]

  before_action :require_login, only: [:new, :create]


  def index
    @products = Product.all
  end

  def show
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      head :not_found
    end
  end

  def new

    @product = Product.new
  end

  def create
    @product = Product.new(product_params())
    if @product.save
      redirect_to product_path(@product.id)
    else
      render :new, status: :bad_request
    end
  end

  def edit
    @product = Product.find_by(id: params[:id])

  end

  def update
    @product = Product.find_by(id: params[:id])

    if @product.update(product_params)
      redirect_to merchant_product_path(@product.id)
    end
  end

  # def destroy
  #   @product = Product.find_by(id: params[:id])
  #   @product.destroy
  #
  #   redirect_to merchant_products_path
  # end

  private
  def product_params
    return params.require(:product).permit(
      :name,
      :price,
      :inventory,
      :merchant_id,
      :description,
      :category_ids,
    )
  end
end
