require "test_helper"
require 'pry'

describe OrdersController do
  let(:order_one) {orders(:one)}
  let(:order_three) {orders(:three)}


    describe "index" do
      it "should get index" do
        # Act
        get cart_path

        # Assert
        must_respond_with :success
      end
    end

    describe "create" do
      it "can create a order with valid data" do
        # Arrange
        order_data = {
          order: {
            email: 'test@test.com',
            mailing_address: '5678 willow st',
            cc: '567856785675678',
            cc_name: 'First Last',
            cc_expiration: '08/21',
            cvv: '456',
            zip: '98765'
          }
        }

        # Assumptions
        test_order = Order.new(order_data[:order])
        test_order.must_be :valid?, "Order data was invalid. Please come fix this test"

        # Act
        expect {
          post orders_path, params: order_data
        }.must_change('Order.count', +1)

        # Assert
        must_redirect_to order_path(Order.last)
      end

      it "does not creat a new order w/ invalid data" do
        # Arrange
        order_data = {
          order: {
            email: 'test@test.com',
          }
        }

        # Assumptions
        Order.new(order_data[:order]).wont_be :valid?, "Order data wasn't invalid. Please come fix this test"

        # Act
        expect {
          post(orders_path, params: order_data)
        }.wont_change('Order.count')

        # Assert
        must_respond_with :bad_request
      end
    end

    describe "show" do

      it "should respond with success for showing an existing order with order_items  " do
        existing_order = orders(:one)
        get order_path(existing_order.id)
        must_respond_with :success
      end


      it "should respond with not found for showing a non-existing order" do
        order = orders(:two)
        
        order.order_items.destroy_all
        order.destroy

        get order_path(order.id)
        must_respond_with :not_found
      end



    end

    describe "edit" do

      it "responds with success for an existing order" do
        get checkout_path(Order.first)

        must_respond_with :success
      end

      it "responds with not_found for a order that D.N.E." do
        get checkout_path(bad_order)

        must_respond_with :redirect
      end
    end

    describe "update" do
    end


    describe "destroy" do
      it "can destroy an existing order" do
        # Arrange
        order = orders(:one)
        # before_order_count = Book.count

        # Act
        expect {
          delete order_path(order)
        }.must_change('puts "inside the must_change argument"; Book.count', -1)

        # Assert
        must_respond_with :redirect
        must_redirect_to orders_path

        # expect(Book.count).must_equal(
        #   before_order_count - 1,
        #   "order count did not decrease"
        # )
      end

      # it "responds with not_found if the order doesn't exist" do
      #   id = bad_order_id
      #   expect {
      #     delete order_path(id)
      #   }.wont_change('Book.count')
      #
      #   must_respond_with :not_found
      # end
    end



end
