class ReviewsController < ApplicationController
  skip_before_action :require_login

  def new
    product = Product.find_by(id: params[:product_id])
    if product
      @review = product.reviews.new
    else
      render_404 
    end

  end

  def create
  end

  private

  def review_params
    params.require(:review).permit(:rating, :product_id, :description)
  end
end
