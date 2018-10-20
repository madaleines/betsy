class OrderItemsController < ApplicationController
  skip_before_action :require_login

  def new
    @order_items = OrderItem.new
  end

  def create
    @order_item = OrderItem.new(order_item_params)
    @order_item.save

    if @order_item.save
      flash[:status] = :success
      flash[:result_text] = "Successfully added to cart"
      redirect_to cart_path
    else
      flash[:status] = :failure
      flash[:result_text] = "Could not add to cart"
      flash[:messages] = @order_item.errors.messages
      render :new, status: :bad_request
    end
  end

  def update
    # if @order_item.update(order_item_params)
    #   flash[:status] = :success
    #   flash[:result_text] = "Successfully updated item"
    #   redirect_to cart_path
      # else
      # flash.now[:error] = "Invalid book data"
    #   # render(:edit, status: :bad_request)
    # end
  end

  def destroy
  end


  private
  def order_item_params
    params.require(:order_item).permit(:quantity, :status, :product_id, :order_id)
  end
end
