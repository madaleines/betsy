require "test_helper"

describe OrderItem do
  let(:order_item) { OrderItem.new }

  it "must be valid" do
    value(order_item).must_be :valid?
  end

  describe 'relations' do
    it "belongs to a product" do

    end

    it "belongs to an order" do

    end

    describe 'validations' do
      before do
        @order_item = Order_item.new(
          product_id: 1,
          order_id: 1,
          quantity: 5,
          status: 'pending'
        )
      end

      it 'is valid with product_id present' do

      end

      it 'is valid with order_id present' do

      end

      it 'is invalid without status' do

      end

      it 'is invalid if quantity is 0' do

      end

      it 'is invalid if quantity is nil' do

      end

    end
  end
end
