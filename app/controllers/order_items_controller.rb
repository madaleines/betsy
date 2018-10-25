class OrderItemsController < ApplicationController
  skip_before_action :require_login

  def create
    product_id = params[:order_item][:product_id]
    #
    unless quantity_is_in_stock?(product_id)
      cannot_order_more_than_stock
      return
    end

    @order_item = @shopping_cart.order_items.new(order_item_params)
    successful_save = @order_item.save
    successful_save ? added_to_cart : could_not_add_to_cart
  end

  def update
    @order_item = find_order_item
    product_id = @order_item.product_id

    unless pending_status?
      cannot_update_paid_order_item
      return
    end

    unless quantity_is_in_stock?(product_id)
      cannot_order_more_than_stock
      return
    end

    @order_item.update(order_item_params)
    successful_update = @order_item.save
    successful_update ? order_item_updated : could_not_update
  end

  def destroy
    @order_item = find_order_item
    pending_status? ? order_item_destroyed : could_not_destroy
  end

  def ship_order_item
    @order_item.update(status: 'shipped')
  end

  def cancel_order_item
    @order_item.update(status: 'cancelled')

  end

  private

  def cannot_update_paid_order_item
    flash[:error] = "Cannot update an order item that is not pending"
    render_400
  end

  def pending_status?
    return @order_item.status == 'pending'
  end

  def could_not_destroy
    flash[:failure] = "Could not delete item from cart due to status being \'#{@order_item.status}\'"
    render_400
  end

  def order_item_destroyed
    @order_item.destroy
    flash[:success] = "Successfully deleted item from cart"
    redirect_to cart_path
  end

  def could_not_update
    flash[:error] = @order_item.errors.messages
    render_400
  end

  def order_item_updated
    flash[:success] = "Successfully updated item"
    redirect_to cart_path
  end

  def could_not_add_to_cart
    flash[:failure] = "Could not add to cart"
    flash[:messages] = @order_item.errors.messages
    render_400
  end

  def added_to_cart
    flash[:success] = "Successfully added to cart"
    redirect_to cart_path
  end

  def cannot_order_more_than_stock
    flash[:error] = "Cannot order more than inventory"
    render_400
  end

  def quantity_is_in_stock?(product_id)
    product = find_order_item_product(product_id)
    quantity = params[:order_item][:quantity].to_i
    inventory = product.inventory
    return quantity < inventory
  end

  def find_order_item_product(product_id)
    return Product.find_by(id: product_id)
  end

  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id)
  end
end
