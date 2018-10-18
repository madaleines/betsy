require "test_helper"

describe Category do
  let(:category) { Category.new }

  it "must be valid" do
    value(category).must_be :valid?
  end

  describe 'validations' do
    before do
      @categories = Category.new(
        name: 'test_category_name'
      )
    end

    it 'is valid when name is present and unique' do


    end



    it 'is invalid without a name' do


    end

    it 'is invalid with a non-unique name' do

    end
  end
end
