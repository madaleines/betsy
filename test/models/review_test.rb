require "test_helper"

describe Review do
  let(:review) { Review.new }

  it "must be valid" do
    value(review).must_be :valid?
  end

  describe 'relations' do
    before do
      @review = Review.new(
        product_id: 1,
        rating: 5,
        description: 'test-description'
      )

    end

    it "belongs to a product" do
      item = @review.product

      expect( item ).must_be_instance_of Product
    end

    describe 'validations' do
      before do
        @review = Review.new(
          product_id: 1,
          rating: 5,
          description: 'test-description'
        )
      end

      it 'is invalid without a rating' do
        @review.rating = nil
        result = @review.valid?

        expect( result ).wont_equal true
      end

      it 'is invalid if rating is not an integer' do
        @review.rating = 'five'

        result = @review.valid?
        expect( result ).wont_equal true
      end

      it 'is valid when rating is between 1 and 5' do
        result = @review.valid?
        expect( result ).must_equal true
      end

      it 'is valid when rating is less than 1' do
        @review.rating = -1
        result = @review.valid?

        expect( result ).must_equal true
      end

      it 'is valid when rating is greater than 5' do
        @review.rating = 6
        result = @review.valid?

        expect( result ).must_equal true
      end

      it 'is valid with product_id present' do
        result = @review.valid?
        expect( result ).must_equal true
      end

      it 'is valid with a description' do
        result = @review.valid?
        expect( result ).must_equal true
      end

      it 'is invalid without a description' do
        @review.description = nil
        result = @review.valid?

        expect( result ).wont_equal true
      end

    end
  end
end
