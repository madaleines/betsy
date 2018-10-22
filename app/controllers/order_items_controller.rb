class OrderItemsController < ApplicationController
  skip_before_action :require_login
  before_action :load_order, only: [:create]


  def new
    @order_items = OrderItem.new
  end

  def create
    @order_item = OrderItem.new(product_id: params[:product_id])
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
    params.require(:order_item).permit(:quantity, :status, :product_id, :order_id)
  end

  def load_order
      @order = Order.find(session[:order_id])
    if @order
      @order = Order.create(status: "unsubmitted")
      session[:order_id] = @order.id
    end
  end
end
