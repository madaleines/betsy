require "test_helper"

describe Review do
  let(:review) { Review.new }

  it "must be valid" do
    value(review).must_be :valid?
  end

  describe 'relations' do
    it "belongs to a product" do

    end

    describe 'validations' do
      before do
        @review = Review.new(
          product_id: 1,
          rating: 5,
          description: 'test-description'
        )
      end

      it 'is valid when rating is between 1 and 5' do

      end

      it 'is valid with product_id present' do

      end

      it 'is invalid if rating is not an integer' do

      end

      it 'is invalid without a rating' do

      end

      it 'is valid with a description' do

      end

      it 'is invalid without a description' do

      end

    end
  end
end
