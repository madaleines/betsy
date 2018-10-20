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
    product = Product.find_by(id: params[:product_id])
    @review = product.reviews.new(review_params)
    
    if @review.save
      flash[:status] = :success
      flash[:result_text] = "Successfully submitted review for: #{product.name}"
      redirect_to products_path(product)
    else
      flash[:status] = :failure
      flash[:result_text] = "Could not submit review for: #{product.name}"
      flash[:messages] = @review.errors.messages
      render :new, status: :bad_request
    end

  end

  private

  def review_params
    params.require(:review).permit(:rating, :product_id, :description)
  end
end
