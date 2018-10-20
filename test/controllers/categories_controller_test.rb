require "test_helper"
require 'pry'

describe CategoriesController do

  describe "logged in users" do
    it "should be able to access new category page" do
      merchant = merchants(:one)
      perform_login(merchant)

      get new_category_path
      must_respond_with :success
    end

    it "should be able to create a new category with valid data" do
      expect {
        post categories_path, params: {category: {name: "zombie food"}}
      }.must_change('Category.count', +1)

      must_respond_with :success
      must_redirect_to root_path
    end


  end

  describe "guest users" do
    it "should not be able to access new category page" do
      get new_category_path
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end




end
