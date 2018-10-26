class MerchantsController < ApplicationController

  def show
    @products = @current_merchant.products
    @order_items = []
    @products.each do |product|
      @order_items << OrderItem.find_by( product_id: product.id )
    end
  end

end
