class StoreController < ApplicationController
  def index
    # Get all products in the store.
    debug_print_cart()
    
    @products = []
    Product.all.each do |p|
      productId = p.id
      @products.push({
        record: p,
        cart_qty: user_cart[productId] || 0
      })
    end
    # Rails.logger.debug "@products: #{@products.to_yaml}"
  end
end
