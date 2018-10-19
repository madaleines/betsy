require "test_helper"

describe ProductsController do
  it "should get index" do
    get merchant_products_path

    must_response_with :success
  end

  it "should get show" do
    id = products(:puzzle)

    get merchant_product_path(id)

    must_response_with :success
  end

  it "should respond with not found for showing a non-existing product" do
    id = products(:puzzle).id
    id.destroy

    get merchant_product_path(id)

    must_response_with :not_found
  end
end
#
#   it "should get new" do
#     get products_new_url
#     value(response).must_be :success?
#   end
#
#   it "should get create" do
#     get products_create_url
#     value(response).must_be :success?
#   end
#
#   it "should get edit" do
#     get products_edit_url
#     value(response).must_be :success?
#   end
#
#   it "should get update" do
#     get products_update_url
#     value(response).must_be :success?
#   end
#
#   it "should get destroy" do
#     get products_destroy_url
#     value(response).must_be :success?
#   end
#
# end
