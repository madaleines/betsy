class CategoriesController < ApplicationController
  before_action :require_login, except [:index, :show]

  def new
    puts params.to_h
    @category = Category.new(params[:merchant_id])
  end

  def create
  end
end
