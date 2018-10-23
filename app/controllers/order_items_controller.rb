class OrderItemsController < ApplicationController
  skip_before_action :require_login

  def create
    product_id = params[:order_item][:product_id]

    unless quantity_is_in_stock?(product_id)
      cannot_order_more_than_stock
      return
    end

    @order_item = create_order_item(order_item_params)
    is_successful_save = @order_item.save
    is_successful_save ? added_to_cart : could_not_add_to_cart
  end

  def update
    @order_item = find_order_item
    is_successful_update = @order_item.update(order_item_params)
    is_successful_update ? order_item_updated : could_not_update
  end

  def destroy
    @order_item = find_order_item
    order_is_pending? ? order_item_destroyed : could_not_destroy
  end

  private

  def find_order_item
    return OrderItem.find_by(id: params[:id])
  end

  def could_not_destroy
    flash[:failure] = "Could not delete item from cart due to status being \'#{@order_item.status}\'"
    render :new, status: :bad_request
  end

  def order_item_destroyed
    @order_item.destroy
    flash[:success] = "Successfully deleted item from cart"
    redirect_to cart_path
  end

  def order_is_pending?
    return @order_item.status == 'pending'
  end

  def could_not_update
    flash[:error] = @order_item.errors.messages
    render :new, status: :bad_request
  end

  def order_item_updated
    @order_item.save
    flash[:success] = "Successfully updated item"
    redirect_to cart_path
  end

  def could_not_add_to_cart
    flash[:failure] = "Could not add to cart"
    flash[:messages] = @order_item.errors.messages
    render :new, status: :bad_request
  end

  def added_to_cart
    flash[:success] = "Successfully added to cart"
    redirect_to cart_path
  end

  def create_order_item(order_item_params)
    return @shopping_cart.order_items.new(order_item_params)
  end

  def cannot_order_more_than_stock
    flash[:error] = "Cannot order more than inventory"
    render :new, status: :bad_request
    return
  end

  def quantity_is_in_stock?(product_id)
    product = Product.find_by(id: product_id)
    quantity = params[:order_item][:quantity].to_i
    inventory = product.inventory
    return quantity < inventory
  end

  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id)
  end
end
