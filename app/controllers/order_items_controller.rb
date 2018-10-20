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
    @order_item = OrderItem.find_by(id: params[:id])

    if @order_item.update(order_item_params)
      # @order_item.save
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
    if @current_user.id == session[:user_id]
      @work.destroy

      flash[:success] = "Successfully destroyed work \"#{@work.title}\""
      redirect_to works_path
    else
      flash[:error] = "You must be logged in as a work's user in order to delete it!"

      redirect_back(fallback_location: root_path)
    end
  end


  private
  def order_item_params
    params.require(:order_item).permit(:quantity, :status, :product_id, :order_id)
  end
end
