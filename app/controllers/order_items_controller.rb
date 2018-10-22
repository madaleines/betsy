class OrderItemsController < ApplicationController
  skip_before_action :require_login

  def create
    @order_item = @shopping_cart.order_items.new(order_item_params)

    is_successful_save = @order_item.save

    if is_successful_save
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
    @order_item = OrderItem.find_by(id: params[:id])

    if @order_item.update(order_item_params)
      @order_item.save
      flash[:status] = :success
      flash[:result_text] = "Successfully updated item"
      redirect_to cart_path
    else
      flash[:status] = :error
      flash[:result_text] = "Invalid book data"
      flash[:messages] = @order_item.errors.messages
      render :new, status: :bad_request
    end
  end

  def destroy
    @order_item = OrderItem.find_by(id: params[:id])

    if @order_item.status == 'pending'
      @order_item.destroy

      flash[:status] = :success
      flash[:result_text] = "Successfully deleted item from cart"
      redirect_to cart_path
    else
      flash[:status] = :failure
      flash[:result_text] = "Could not delete item from cart due to status being \'#{@order_item.status}\'"
      render :new, status: :bad_request
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id)
  end
end
