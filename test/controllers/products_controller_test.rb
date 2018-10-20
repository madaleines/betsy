require "test_helper"
require 'pry'

describe ProductsController do
  let(:one) {merchants(:one)}

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
    login(one)
    # merchant = merchants(:one)

    get new_merchant_product_path(one.id)

    must_respond_with :success
  end

  it 'it can create a product with valid data' do
    login(one)
    product_info = {
      mazze: {
        name: "some toy",
        price: 25,
        description: "An integlligent brain plushie",
        inventory: 10,
        category_ids: [Category.first.id],
        merchant: merchants(:one)
      }
    }

    test_product = Product.new(product_info[:mazze])
    valid = test_product.valid?
    valid.must_equal true, "Product data was invalid: #{test_product.errors.messages}, please come fix this test"


    expect{
      post merchant_products_path(one.id), params: product_info
    }.must_change('Product.count', +1)

    must_redirect_to product_path(Product.last.id)
  end
end

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
