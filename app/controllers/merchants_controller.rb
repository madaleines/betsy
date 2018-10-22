class MerchantsController < ApplicationController

  def dashboard
    @merchant = Merchant.find_by(id: session[:id] )
  end

  if @merchant.id == session[:id] || session[:id] != nil
    flash[:status] = :success
    flash[:result_text] = "Successfully made it to the dashboard"
  else
    flash[:status] = :failure
    flash[:result_text] = "Could not pull up your dashboard"
    flash[:messages] = @merchant.errors.messages
    redirect_to root_path
  else
  end

  def show
    @merchant = Merchant.find_by(id: params[:id] )
    if @merchant == nil
      flash[:status] = :failure
      flash[:result_text] = "Merchant could not be found"
      flash[:messages] = @merchant.errors.messages
      redirect_to root_path
    else
      @products = @merchants.products
    end
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
