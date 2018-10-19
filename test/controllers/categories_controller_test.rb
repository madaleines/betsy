require "test_helper"

describe CategoriesController do
  describe "new" do
    it "should get new category page" do
      id = merchants(:one).id
      get new_merchant_category_path(id)

      must_respond_with :success
    end
  end

  describe "create" do

    it "should create new category with a valid data" do
      expect {
        post merchant_categories_path, params: {category: {name: "zombie food"}}
      }.must_change('Category.count', +1)

      must_respond_with :redirect
      must_redirect_to merchant_path
    end

  end



end
