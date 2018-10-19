class CategoriesController < ApplicationController
  before_action :require_login, except [:index, :show]

  def new
  end

  def create
  end
end
