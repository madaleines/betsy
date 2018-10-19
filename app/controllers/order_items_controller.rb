class OrderItemsController < ApplicationController
  skip_before_action :require_login

  def new
    @order_items = (OrderItem.all).sort_by do |order_item|
      order_item.id
    end
  end

  def create
    @order_item = OrderItem.new(order_items_params)
    if @order_item.save
      flash[:status] = :success
      flash[:result_text] = "Successfully created #{@order_item.singularize} #{@order_item.id}"
      redirect_to order_item_path(@order_item)
    else
      flash[:status] = :failure
      flash[:result_text] = "Could not create #{@order_item.singularize}"
      flash[:messages] = @order_item.errors.messages
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
    params.require(:order_item).permit(:quantity, :status, :order_id, :product_id)
  end
end
