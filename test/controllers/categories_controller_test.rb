require "test_helper"
require 'pry'

describe CategoriesController do

  describe "logged in users" do
    it "should get new category page for merchants that exist" do
      merchant = merchants(:one)
      perform_login(merchant)

      get new_category_path
      must_respond_with :success
    end

  end

  # describe "new" do
  #   it "should not get new category page for merchants that do not exist" do
  #     merchant = merchants(:one)
  #     merchant.products.destroy_all
  #     merchant.categories.destroy_all
  #
  #     merchant.destroy
  #     get new_merchant_category_path(merchant.id)
  #
  #     must_respond_with :not_found
  #   end
  #
  # end
  #
  # describe "create" do
  #
  #   it "should create new category with a valid data" do
  #     expect {
  #       post merchant_categories_path, params: {category: {name: "zombie food"}}
  #     }.must_change('Category.count', +1)
  #
  #     must_respond_with :redirect
  #     must_redirect_to merchant_path
  #   end
  #
  # end



end
