require "test_helper"

describe Merchant do

  describe 'relations' do
    it 'has many products' do
      m = Merchant.first
      products = m.products
      expect(products.first).must_be_instance_of Product
    end

    it 'has some order_items through products' do
    end

  end

  describe 'validations' do
    before do
      @merchant = Merchant.new(
        username: 'test_merchant',
        email: 'test_merchant@braineaze.com'
      )
    end

    it 'is valid when username is present and unique and email is present' do


    end

    it 'is valid when email is present and unique and username is present' do


    end

    it 'is invalid without a username' do


    end

    it 'is invalid without a email' do


    end

    it 'is invalid with a non-unique username' do

    end

    it 'is invalid with a non-unique email' do

    end
  end
end
