require "test_helper"
require 'pry'

describe OrderItemsController do
  describe "new" do
    order_item = OrderItem.first

    it "should get new" do
      get new_order_order_item_path(order_item.id)
      must_respond_with :success
    end
  end

  describe "create" do
    order = Order.first
    product = Product.first
    order_item_data = {
      order_item1: {
        quantity: 5,
        status: 'pending',
        order_id: order.id,
        product_id: product.id
      }
    }

    it "creates an new order item" do
      order_item_count = OrderItem.count

      expect {
        post new_order_order_item_path, params: order_item_data
      }.must_change('OrderItem.count', +1)

      #Assert
      must_redirect_to cart_path(OrderItem.last)
    end

    it "renders 404 not_found for a bogus order_item data" do

    end
  end

  describe "edit" do
    order_item = OrderItem.first
    id = order_item.id

    it "succeeds for an existing order_item ID" do
    end

    it "renders 404 not_found for a bogus order_item ID" do

    end
  end

  describe "update" do
    order_item = OrderItem.first
    id = OrderItem.first.order_id

    it "succeeds for valid data and an existing order_item ID" do
      patch order_order_item_path(order_item.id, id)

      must_respond_with :success
      must_redirect_to order_path(id)
    end

    it "renders bad_request and does not update the DB for bogus data" do

    end


    it "renders bad_request for bogus data" do

    end

    it "renders 404 not_found for a bogus order_item ID" do

    end

  end

  describe "delete" do
    order_item = OrderItem.first
    id = OrderItem.first.id

    it "succeeds for an existing order_item ID" do
      delete order_order_item_path(order_item.id, id)

      must_respond_with :success
      must_redirect_to order_path(id)
    end

    it "renders 404 not_found and does not delete the DB for a bogus order_item ID" do

    end
  end

end
