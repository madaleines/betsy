class MerchantsController < ApplicationController

  def show
    if @current_merchant == nil
      flash[:status] = :failure
      flash[:result_text] = "You are not authorized to view merchant dashboard"
      redirect_to root_path
    else
      @products = @current_merchant.products
      @order_items = []
      @products.each do |product|
        @order_items << OrderItem.find_by( product_id: product.id )
      end
      @revenue = @current_merchant.revenue
    end
  end

  def index
  end

end
