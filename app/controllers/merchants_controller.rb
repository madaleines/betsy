class MerchantsController < ApplicationController
  skip_before_action :require_login

  def show
    @merchant = Merchant.find_by(id: params[:id] )

    if @merchant.id != session[:merchant_id]
      flash[:status] = :failure
      flash[:result_text] = "You are not authorized to view this dashboard"
      redirect_to merchant_products_path(@merchant.id)
    elsif @merchant == nil
      flash[:status] = :failure
      flash[:result_text] = "Merchant could not be found"
      flash[:messages] = @merchant.errors.messages
      redirect_to root_path
    end

    @products = @merchant.products
    flash[:status] = :success
  end


  def order_summary
    @merchant = Merchant.find_by(id: params[:id] )
    # if @merchant == nil
    # flash[:status] = :failure
    # flash[:result_text] = "Merchant could not be found"
    # flash[:messages] = @merchant.errors.messages
    # redirect_to root_path
    # else
  end
end
