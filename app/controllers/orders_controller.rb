class OrdersController < ApplicationController
  skip_before_action :require_login
  def index
    if @shopping_cart.order_items.empty?
      flash[:alert] = "Your cart is empty"
    end
    # # @orders = Order.all
    # order_items = []
    # if @shopping_cart
    #   @shopping_cart.order_items.each do |order_item|
    #     order_items  << order_item
    #   end
    # end
    # return order_items
  end


  def show
    @order = find_order
    render_404 if @order.nil?
  end


  def edit #checkout form
    if @shopping_cart.order_items.empty?
      flash[:alert] = "Cart - empty"
      redirect_to cart_path
    else
      return @shopping_cart
    end
  end


  def update
    @order = find_order
    if valid_shopping_cart?

      @order.update_attributes(status: "paid")
      @order.update_attributes(billing_params)

      if @order.update(billing_params)
        @order.order_items.each do
          order_item.update_attributes(status: "paid")
        end
      end

      if @order.save
        @order.order_items.each do |order_item|
          product = Product.find(order_item.product_id)
          product.change_inventory(item.quantity)
        end
        redirect_to order_path(@order.id)
      else

        flash.now[:error] = @order.errors
        render :edit, status: :error
      end
    end
  end

  def destroy #clear cart
  end

  private

  def redirect_no_items_in_cart
    flash[:error] = "There are no items to checkout"
    redirect_to root_path
    return
  end


  def cart_has_no_items?
    return @shopping_cart.order_items.nil?
  end

  def valid_shopping_cart?
    return !@shopping_cart.nil? && @shopping_cart.status == "cart"
  end

  def billing_params
    params.require(:order).permit(:email, :mailing_address, :cc, :cc_name, :cc_expiration, :cvv, :zip)
  end


end
