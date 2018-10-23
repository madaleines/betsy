require "test_helper"
require 'pry'

describe OrderItemsController do
  describe "Create" do
    it "it can create an Order Item (add item to cart)" do
      product = Product.first
      order_item_data = {
        order_item: {
          quantity: 5,
          product_id: product.id
        }
      }
      expect {
        post order_items_path, params: order_item_data
      }.must_change('OrderItem.count', +1)

      must_respond_with :redirect
      must_redirect_to cart_path
    end

    it "renders 404 not_found for a bogus order_item data when trying to add to cart" do
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

      expect {
        post order_items_path, params: order_item_data
      }.wont_change('OrderItem.count')

      must_respond_with :bad_request
    end
  end

  describe "Update" do
    it "successfully updates the Order Item quantity" do
      order = Order.first
      order_item = OrderItem.first

      patch order_item_path(order_item.id), params: {
        order_item: {quantity: 4}
      }

      must_redirect_to cart_path
    end

    it "renders a 404 not_found for bogus order item data" do
      order = Order.first
      order_item = OrderItem.first

      patch order_item_path(order_item.id), params: {
        order_item: {quantity: 'four'}
      }
      must_respond_with :bad_request
    end
  end

  describe "Destroy" do
    it "deletes an order item when status is pending" do
      order_item = OrderItem.find_by(status: "pending")
      order = order_item.order

      expect{
        delete order_item_path(order_item.id)
      }.must_change('order.order_items.count', -1)

      must_respond_with :redirect
      must_redirect_to cart_path
    end

    it "does not delete order item if status not pending" do
      order_item = OrderItem.first
      order = order_item.order

      order_item.status = "shipped"

      expect {
        delete order_item_path(order_item.id)
      }.wont_change('order.order_items.count')

      must_respond_with :bad_request
    end
  end
end
