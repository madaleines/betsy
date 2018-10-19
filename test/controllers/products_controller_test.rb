require "test_helper"

describe ProductsController do
  it "should get index" do
    get products_path

    must_respond_with :success
  end

  it "should get show" do
    id = products(:puzzle)

    get product_path(id)

    must_respond_with :success
  end

  it "should respond with not found for showing a non-existing product" do
    id = products(:puzzle)
    id.destroy

    get product_path(id)

    must_respond_with :not_found
  end

  it 'should get a new form to add products' do
    get new_product_path

    must_respond_with :success
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
