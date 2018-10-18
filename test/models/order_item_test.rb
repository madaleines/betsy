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
        result = @order_item.valid?
        expect( result ).must_equal true
      end

      it 'is valid with order_id present' do
        result = @order_item.valid?
        expect( result ).must_equal true
      end

      it 'is invalid without status' do
        @order_item.status = nil
        result = @order_item.valid?
        expect( @order_item ).errors.messages_must_include :status
      end

      it 'is invalid if quantity is 0' do
        @order_item.quantity = 0
        result = @order_item.valid?
        expect( @order_item ).errors.messages_must_include :quantity
      end

      it 'is invalid if quantity is nil' do
        @order_item.quantity = nil
        result = @order_item.valid?
        expect( @order_item ).errors.messages_must_include :quantity
      end

    end
  end
end
