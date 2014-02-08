class StoreController < ApplicationController
  def index
    # Get all products in the store.
    @products = Product.all
  end
end
