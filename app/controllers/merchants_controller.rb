class MerchantsController < ApplicationController
  skip_before_action :require_login

  def show
    @merchant = Merchant.find_by(id: params[:id] )

    if @merchant == nil
      flash[:status] = :failure
      flash[:result_text] = "Merchant could not be found"
      redirect_to root_path
    elsif @merchant.id != session[:merchant_id]
      flash[:status] = :failure
      flash[:result_text] = "You are not authorized to view this dashboard"
      redirect_to merchant_products_path(@merchant.id)
    else
      @products = @merchant.products
      @order_items = []
      @products.each do |product|
        @order_items << OrderItem.find_by(product_id: product.id )
        flash[:status] = :success
        @revenue = 0.0
        
        @order_items.each do |order_item|
          @merchant.products.each do |product|
            if order_item.product == product
              @revenue += product.price
            end
          end
        end
      end
    end
  end

end
