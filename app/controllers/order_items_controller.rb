class OrderItemsController < ApplicationController
  skip_before_action :require_login

  def new
    @order_items = OrderItem.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end


  private
  def order_item_params
    params.require(:order_item).permit(:quantity, :status, :order_id, :product_id)
  end
end
