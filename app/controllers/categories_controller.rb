class CategoriesController < ApplicationController

  def new
    puts params.to_h
    @category = Category.new(params[:merchant_id])
  end

  def create
  end
end
