require "test_helper"

describe Order do

  describe 'relations' do
    it "has a list of order items" do
      order = orders(:one)
      order.must_respond_to :order_items

      order.order_items.each do |order_item|
        order_item.must_be_kind_of  OrderItem
      end
    end
  end

  describe 'validations' do
    before do
      @order = Order.new(
        email: 'aaa@gmail.com',
        mailing_address: '12345 A Street',
        cc: 1234123412341234,
        cc_name: 'Aaa Aaaaaa',
        cc_expiration: '20/22',
        cvv: 123,
        zip: 12345
      )
    end

    it 'is valid when email is present and unique' do
      is_valid = @order.valid?
      expect( is_valid ).must_equal true
    end

    it 'is invalid when email is missing' do
      @order.email = nil
      is_valid = @order.valid?
      expect( is_valid ).must_equal false
      expect( @order.errors.messages ).must_include :email
    end

    it 'is invalid when email is non-unique' do
      @order.email = Order.first.email
      is_valid = @order.valid?
      expect( is_valid ).must_equal false
    end

    it 'is valid when mailing address is present' do
      is_valid = @order.valid?
      expect( is_valid ).must_equal true

    end

    it 'is invalid when mailing address is missing' do
      @order.mailing_address = nil
      is_valid = @order.valid?
      expect( is_valid ).must_equal false
      expect( @order.errors.messages ).must_include :mailing_address
    end

    it 'is valid when cc is present' do
      is_valid = @order.valid?
      expect( is_valid ).must_equal true
    end

    it 'is invalid when cc is missing' do
      @order.cc = nil
      is_valid = @order.valid?
      expect( is_valid ).must_equal false
      expect( @order.errors.messages ).must_include :cc

    end



    it 'is valid with an integer cc number' do

    end

    it 'is valid with a cc name' do
    end

    it 'is valid with ' do
    end
  end
end
