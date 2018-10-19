class ApplicationController < ActionController::Base
  before_action :current_merchant
  before_action :current_cart

  private

  def current_merchant
    @current_merchant = Merchant.find_by(id: session[:merchant_id])
  end

  def require_login
    if @current_merchant.nil?
      flash[:error] = "You must be logged in to view this section"
      redirect_to session_path
    end
  end

  def current_cart
    if session[:order_id]
      @shopping_cart = Order.find_by(id: session[:order_id])
    else
      @shopping_cart = Order.create
      session[:order_id] = @shopping_cart.id
    end
  end
end
