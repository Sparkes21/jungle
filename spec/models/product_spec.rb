require 'rails_helper'

RSpec.describe Product, type: :model do
  before(:each) do 
    @product = Product.new
    @category = Category.new
    @product.name = "Test"
    @product.price_cents = 12345
    @product.quantity = 3
    @product.category = @category
  end

  it "saves successfully with all four fields set" do
    expect(@product.valid?).to be true
  end
  describe 'Validations' do
    context "validates name presence" do
      it 'throws an error when name is blank' do
        @product.name = nil
        @product.save
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end
    end
    context "validates price presence" do
      it 'throws an error when price is blank' do
        @product.price_cents = nil
        @product.save
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end
    end
    context "validates quantity presence" do
      it 'throws an error when quantity is blank' do
        @product.quantity = nil
        @product.save
        expect(@product.errors.full_messages).to include("Quantity can't be blank")
      end
    end
    context "validates category presence" do
      it 'throws an error when category is blank' do
        @product.category = nil
        @product.save
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end
    end
    
  end

end
