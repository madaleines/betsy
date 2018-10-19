class CategoriesController < ApplicationController

  def new
    # puts params.to_h
    @category = Category.new
  end

  def create
  end
end
