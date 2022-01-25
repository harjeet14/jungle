require 'rails_helper'

RSpec.describe Product, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'Validations' do
   it "should not save product without name " do
    @category = Category.new(name:"Furniture")
    @product = Product.new(price_cents: 5000,quantity: 2,category:@category)
    @product.save
    expect(@product.errors.full_messages).to include(/can't be blank/) 
  end
  it "should not save product without quantity" do
    @category = Category.new(name:"Furniture")
    @product = Product.new(price_cents: 50000, name: "chair", category:@category)
    @product.save
    expect(@product.errors.full_messages).to include(/can't be blank/) 
  end
  it "should not save product without price" do
    @category = Category.new(name:"Furniture")
    @product = Product.new(name: "chair",quantity: 2, category:@category)
    @product.save
    expect(@product.errors.full_messages).to include(/can't be blank/) 
  end
  it "should not save product without category" do
    @category = Category.new(name:"Furniture")
    @product = Product.new(name: "chair",quantity: 2, price: 4000)
    @product.save
    expect(@product.errors.full_messages).to include(/can't be blank/) 
  end
  it "should save product with all true validations" do
    @category = Category.new(name:"Furniture")
    @product = Product.new(name: "chair",quantity: 2,price: 2000, category:@category)
    @product.save
    expect(@product.errors).not_to include(/can't be blank/) 
  end
end
end