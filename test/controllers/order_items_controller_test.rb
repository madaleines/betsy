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
    it "can existing order_item ID" do
      order = Order.first
      product = Product.first
      order_item_data = {
        order_item: {
          quantity: 5,
          status: 'pending',
          order_id: order.id,
          product_id: product.id
        }
      }

      new_order_item = OrderItem.new(order_item_data[:order_item])
      expect {
        post order_order_items_path(order.id), params: order_item_data
      }.must_change('OrderItem.count', +1)

      must_respond_with :redirect
      must_redirect_to cart_path
    end

    it "renders 404 not_found for a bogus order_item data" do
      order = Order.first
      product = Product.first
      order_item_data = {
        order_item: {
          quantity: 0,
          status: 'pending',
          order_id: order.id,
          product_id: product.id
        }
      }

      OrderItem.new(order_item_data[:order_item]).wont_be :valid?, "Order data wasn't invalid. Please come fix this test"

      # Act
      expect {
        post order_order_items_path(order.id), params: order_item_data
      }.wont_change('OrderItem.count')

      # Assert
      must_respond_with :bad_request
    end
  end

  describe "update" do
    it "succeeds updates an existing order_item" do
      order = Order.first
      order_item = OrderItem.first


      patch order_order_item_path(order.id, order_item.id), params: {
        order_item: {quantity: 4}
      }

      must_redirect_to cart_path
    end

    it "renders a 404 not_found for bogus order item data" do
      order = Order.first
      order_item = OrderItem.first


      patch order_order_item_path(order.id, order_item.id), params: {
        order_item: {quantity: 'four'}
      }

      must_respond_with :bad_request
    end

  end

  describe "delete" do
    #   order_item = OrderItem.first
    #   id = OrderItem.first.id
    #
    #   it "succeeds for an existing order_item ID" do
    #     delete order_order_item_path(order_item.id, id)
    #
    #     must_respond_with :success
    #     must_redirect_to order_path(id)
    #   end
    #
    #   it "renders 404 not_found and does not delete the DB for a bogus order_item ID" do
    #
    #   end
  end
end
# describe "edit" do
#   order_item = OrderItem.first
#   id = OrderItem.first.order_id
#
#   it "succeeds for an existing order_item ID" do
#     get edit_order_order_item_path(order_item.id, id)
#
#     must_respond_with :success
#     must_redirect_to order_order_item_path(order_item.id, id)
#   end
#
#   it "renders 404 not_found for a bogus order_item ID" do
#
#   end
# end
#
# describe "update" do
#   order_item = OrderItem.first
#   id = OrderItem.first.order_id
#
#   it "succeeds for valid data and an existing order_item ID" do
#     patch order_order_item_path(order_item.id, id)
#
#     must_respond_with :success
#     must_redirect_to order_path(id)
#   end
#
#   it "renders bad_request and does not update the DB for bogus data" do
#
#   end
#
#
#   it "renders bad_request for bogus data" do
#
#   end
#
#   it "renders 404 not_found for a bogus order_item ID" do
#
#   end
#
# end
#
#
