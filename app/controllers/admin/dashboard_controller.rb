class Admin::DashboardController < ApplicationController

  def show
    @products = Product.count(:all)
    @Categories = Category.count(:all)
  end
end
