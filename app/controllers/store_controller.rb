class StoreController < ApplicationController
  def index
    # Get all products in the store.
    @products = Products.all
  end
end
