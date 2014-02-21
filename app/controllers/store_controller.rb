class StoreController < ApplicationController
  def index
    # Get all products in the store.
    # debug_print_cart()

    @products = []
    Product.all.each do |product|
      productId = product.id.to_s
      qty = user_cart[productId]
      
      @products.push({
        record: product,
        cart_qty: qty
      })
    end
    # Rails.logger.debug "@products: #{@products.to_yaml}"
  end
end
