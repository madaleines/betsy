require "test_helper"

describe OrdersController do
  let(:bad_order_id) { Order.first.destroy.id }

    describe "index" do
      it "should get index" do
        # Act
        get orders_path

        # Assert
        must_respond_with :success
      end
    end

    describe "new" do
      it "can get the new page" do
        get new_order_path

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

      it "should respond with success for showing an existing order" do
        # Arrange
        existing_order = orders(:one)

        # Act
        get order_path(existing_order.id)

        # Assert
        must_respond_with :success
      end

      it "should respond with not found for showing a non-existing order" do
        # Arrange
        # order = orders(:poodr)
        # id = order.id

        # get order_path(id)
        # must_respond_with :success
        #
        #
        # order.destroy

        # Act
        get order_path(bad_order_id)

        # Assert
        must_respond_with :missing
      end

    end

    describe "edit" do
      it "responds with success for an existing order" do
        get edit_order_path(Order.first)
        must_respond_with :success
      end

      it "responds with not_found for a order that D.N.E." do
        get edit_order_path(bad_order_id)
        must_respond_with :not_found
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

      it "responds with not_found if the order doesn't exist" do
        id = bad_order_id
        expect {
          delete order_path(id)
        }.wont_change('Book.count')

        must_respond_with :not_found
      end
    end



end
