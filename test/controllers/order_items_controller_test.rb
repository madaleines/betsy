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
    it "deletes an order item when status is pending" do
      order_item = OrderItem.find_by(status: "pending")
      order = order_item.order

      expect{
        delete order_order_item_path(order.id, order_item.id)
      }.must_change('order.order_items.count', -1)

      must_respond_with :redirect
      must_redirect_to cart_path
    end

    it "does not delete order item if status not pending" do
      order_item = OrderItem.first
      order = order_item.order

      order_item.status = "shipped"

      expect {
        delete order_order_item_path(order.id, order_item.id)}.wont_change('order.order_items.count')

        must_respond_with :bad_request
      end
    end

  end
