require "test_helper"

describe OrderItemsController do
  let(:plushie) {products(:plushie)}

  describe "Create" do
    it "it can create an Order Item (add item to cart)" do
      product = plushie
      qty_requested = 7
      order_item_data = {
        order_item: {
          quantity: qty_requested,
          product_id: product.id
        }
      }
      expect {
        post order_items_path, params: order_item_data
      }.must_change('OrderItem.count', +1)

      OrderItem.last.quantity.must_equal qty_requested
      must_respond_with :redirect
      must_redirect_to cart_path
    end

    it "renders 404 not_found for a bogus order_item data when trying to add to cart" do
      order = Order.first
      product = plushie
      order_item_data = {
        order_item: {
          quantity: 0,
          product_id: product.id
        }
      }

      expect {
        post order_items_path, params: order_item_data
      }.wont_change('OrderItem.count')

      must_respond_with :bad_request
    end

    it "renders a bad request if the quantity requested is more than the product inventory" do
      order = Order.first
      product = plushie
      bad_qty = product.inventory + 1
      order_item_data = {
        order_item: {
          quantity: bad_qty,
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
      order_item = OrderItem.first
      updated_qty = order_item.quantity + 1

      patch order_item_path(order_item.id), params: {
        order_item: {
          quantity: updated_qty
        }
      }
      order_item.reload
      order_item.quantity.must_equal updated_qty
      must_redirect_to cart_path
    end

    it "renders a 404 not_found for bogus order item data" do
      order_item = OrderItem.first
      original_qty = order_item.quantity

      patch order_item_path(order_item.id), params: {
        order_item: {
          quantity: 'four'
        }
      }
      must_respond_with :bad_request
      order_item.quantity.must_equal original_qty
    end

    it "renders a bad request if the quantity updated is more than the product inventory" do
      order_item = OrderItem.first
      original_qty = order_item.quantity
      bad_qty = original_qty + 100

      patch order_item_path(order_item.id), params: {
        order_item: {
          quantity: bad_qty
        }
      }

      order_item.quantity.must_equal original_qty
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
