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
    it 'is valid with an email' do

    end

    it 'is valid with a mailing address' do
    end

    it 'is valid with a cc' do

    end

    it 'is valid with an integer cc number' do

    end

    it 'is valid with a cc name' do
    end

    it 'is valid with ' do
    end
  end
end
