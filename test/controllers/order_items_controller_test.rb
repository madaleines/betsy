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
    @order = Order.first
    @product = Product.first
    @order_item = OrderItem.new(quantity: 5, status: 'pending', order_id: @order.id, product_id: @product.id)

    it "succeeds for an existing order_item ID" do
      order_item_count = OrderItem.count

      post order_order_items_path(@order.id)
      expect( order_item_count ).must_equal order_item_count + 1
      must_respond_with :success
    end

    it "renders 404 not_found for a bogus order_item data" do
      @order.id = 12
      order_item_count = OrderItem.count

      post order_order_items_path(@order.id)
      expect( order_item_count ).must_equal order_item_count + 1
      must_respond_with :not_found

    end
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
