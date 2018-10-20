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
      flash[:result_text] = "Successfully created"
      redirect_to order_path(@order_item.order.id)
    else
      render :new, status: :bad_request
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end


  private
  def order_item_params
    params.require(:order_item).permit(:quantity, :status, :product_id, :order_id)
  end
end
