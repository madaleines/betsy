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
    before do
      @product = Product.first
      @order = Order.first
      @orderitem_data = {
        order_item: {
          quantity: 5,
          status: 'pending',
          product_id: @product.id,
          order_id: @order.id
        }
      }
    end

    it "will create a new order item with valid data" do
      new_order_item = OrderItem.new(@orderitem_data[:order_item])
      new_order_item.must_be :valid?, "Order item data was invalid. Please come fix this test"



      expect{ post order_order_items_path(@order.id), params: @orderitem_data }.must_change('OrderItem.count', +1)
      must_respond_with :redirect
      must_redirect_to order_path(@order.id)
    end

    it "does not create a new order item if data is invalid" do
      @orderitem_data[:order_item][:product_id] = 1

      OrderItem.new(@orderitem_data[:order_item]).wont_be :valid?, "Order item data wasn't invalid. Please come fix this test"

      # Act
      expect{ post order_order_items_path(@order.id), params: @orderitem_data }.wont_change('OrderItem.count')

      # Assert
      must_respond_with :bad_request
    end
  end
end
# describe "edit" do
#   order_item = OrderItem.first
#   id = order_item.id
#
#   it "succeeds for an existing order_item ID" do
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
# describe "delete" do
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
# end
