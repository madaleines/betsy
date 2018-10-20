require "test_helper"

describe ReviewsController do
  let(:one) { merchants(:one)}
  let(:plushie) { products(:plushie) }

  describe "new" do
    it "logged in users can get to a new review page" do
      login(one)
      get new_product_review_path(plushie.id)
      must_respond_with :success
    end

    it "logged in users can't get to a new review page for non-existent product" do
      login(one)
      plushie.destroy
      get new_product_review_path(plushie.id)
      must_respond_with :not_found
    end

    it "guest users can get to a new review page" do
      get new_product_review_path(plushie.id)
      must_respond_with :success
    end

    it "guest users can't get to a new review page for non-existent product" do
      plushie.destroy
      get new_product_review_path(plushie.id)
      must_respond_with :not_found
    end
  end

  describe "create" do

  end


end
