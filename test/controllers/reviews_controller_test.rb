require "test_helper"

describe ReviewsController do
  describe "new" do
    review = Review.first
    product = Review.first.product_id

    it "should get new" do
      get new_product_reviews_path(product.id)
      must_respond_with :success
    end
  end

  describe "create" do
    product = Product.first
    review = Review.new(rating: 3, description: "test-description", product_id: product.id)

    it "succeeds for an existing order_item ID" do
      review_count = Review.count

      post product_reviews_path(product.id)
      expect( review_count ).must_change('Review.count' +1)
      must_respond_with :success
    end

    it "renders 404 not_found for a bogus order_item data" do
      must_respond_with :failure
    end
  end


  describe "delete" do
    before do
      review = Review.first
      id = Review.first.product_id
    end

    it "succeeds for an existing order_item ID" do
      delete product_review_path(id)

      must_respond_with :success
      must_redirect_to reviews_path
    end

    it "renders 404 not_found and does not delete the DB for a bogus order_item ID" do

    end
  end

end
