class OrdersController < ApplicationController

  def index
    order_items = []
    if @shopping_cart
      @shopping_cart.order_items.each do |order_item|
        order_items  << order_item
      end
    end
    return order_items
  end


  def show
    order_items = []
    paid_order = Order.find_by(id: params[:id])
    paid_order.order_items.each do |order_item|
      order_items << order_item
    end
    return order_items
  end


  def edit
    return @shopping_cart
  end


  def update
    if valid_shopping_cart?

      @shopping_cart.update_attributes(billing_params)
      @shopping_cart.update_attributes(status: "paid")

      if @shopping_cart.update(billing_params)
        @shopping_cart.order_items.each do
          order_item.update_attributes(status: "paid")
        end
      end

      if @shopping_cart.save
        @shopping_cart.order_items.each do |order_item|
          product = Product.find(order_item.product_id)
          product.change_inventory(item.quantity)
        end
        redirect_to order_path(@shopping_cart.id)
      else
        flash.now[:status] = :failure
        flash.now[:result_text] = "Sorry, could not update your order!"
        flash.now[:messages] = @shopping_cart.errors.messages
        render :edit, status: :bad_request
      end
    end
  end

  def destroy
  end

  private

  def valid_shopping_cart?
    return !@shopping_cart.nil? && @shopping_cart.status == "pending"
  end

  def billing_params
    params.require(:order).permit(:email, :mailing_address, :cc, :cc_name, :cc_expiration, :cvv, :zip)
  end

  
end
