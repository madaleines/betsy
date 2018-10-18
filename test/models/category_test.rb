require "test_helper"

describe Category do
  let(:category) { Category.new }

  it "must be valid" do
    value(category).must_be :valid?
  end

  describe 'validations' do
    before do
      @category = Category.new(
        name: 'test_category_name'
      )
    end


    @CATEGORIES = %w[games toys books vitamins meditation]

    it 'is valid when name is present and unique' do
      @category.name = "apparel"

      result = @category.valid?

      expect(result).must_equal true
      expect( @category ).errors.messages_must_include :name
    end



    it 'is invalid without a name' do
      @category.name = nil

      result = @category.valid?

      expect(result).wont_equal true
      expect( @category ).errors.messages_must_include :name
    end


    CATEGORIES = %w[games toys books vitamins meditation]

    it 'is invalid with a non-unique name' do
      @category.name = CATEGORIES.first

      result = @category.valid?

      expect(result).wont_equal true
      expect( @category ).errors.messages_must_include :name
    end

  end
end
