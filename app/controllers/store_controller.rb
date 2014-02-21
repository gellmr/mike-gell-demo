class StoreController < ApplicationController
  def index
    # Get all products in the store.
    # debug_print_cart()
    @products = []
    @all_products = Product.order("name").page(params[:page]).per(3)
    @all_products.each do |product|
      productId = product.id.to_s
      qty = user_cart[productId]
      @products.push({
        record: product,
        cart_qty: qty,
        subtotal: product.unitPrice * qty.to_i
      })
    end
    # Rails.logger.debug "@products: #{@products.to_yaml}"
  end
end
