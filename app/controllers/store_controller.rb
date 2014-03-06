class StoreController < ApplicationController
  def index
    # Get all products in the store.
    # debug_print_cart()
    @products = []
    @grand_total = 0
    @all_products = Product.order("name").page(params[:page]).per(3)
    @all_products.each do |product|
      productId = product.id.to_s
      qty = user_cart[productId]
      @grand_total += subtot = product.unitPrice * qty.to_i
      @products.push({
        record: product,
        cart_qty: qty,
        subtotal: nil
      })
    end
    # Rails.logger.debug "@products: #{@products.to_yaml}"
  end

  def product_search
    result = Product.where("name LIKE :search_string OR description LIKE :search_string", {
      search_string: sane_search_params[:queryString]
    })
    result.each do |r|
      Rails.logger.debug "Search result: #{r}"
    end
    head :ok
  end

  private
    # Strong params
    def sane_search_params
      params.require(:productSearch).permit(
        :queryString
      )
    end
end
