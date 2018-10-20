require "test_helper"
require 'pry'

describe ProductsController do
  let(:one) {merchants(:one)}
  let(:bad_product_id) {Product.first.destroy.id}

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

    get new_merchant_product_path(one.id)

    must_respond_with :success
  end

  it 'it can create a product with valid data' do
    login(one)


    product_info = {
      product: {
        name: "some toy",
        price: 25,
        description: "An integlligent brain plushie",
        inventory: 10,
        merchant: merchants(:one),
        category_ids: [categories(:toy).id]
      }
    }

    test_product = Product.new(product_info[:product])
    # test_product.must_be :valid?, "Product data was invalid. fix this test"
# binding.pry
    valid = test_product.valid?
    valid.must_equal true, "Product data was invalid: #{test_product.errors.messages}, please come fix this test"

    expect{
      post(merchant_products_path(one.id), params: product_info)
    }.must_change('Product.count', +1)

    must_redirect_to product_path(Product.last)
  end

  it 'does not create a new product with invalid data' do
    login(one)

    product_data = {
      product: {
        merchant: merchants(:one),
        category_ids: [categories(:toy).id]
      }
    }

    Product.new(product_data[:product]).wont_be :valid?

    expect {
      post(merchant_products_path(one.id), params: product_data)
    }.wont_change('Product.count')

    must_respond_with :bad_request
  end

  it 'responds with success for an existing product' do
    login(one)

    get edit_merchant_product_path(Product.first)

    must_respond_with :success
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
#
# end
