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
      @grand_total += subtot = product.unit_price * qty.to_i
      @products.push({
        record: product,
        cart_qty: qty,
        subtotal: nil
      })
    end
    # Rails.logger.debug "@products: #{@products.to_yaml}"
  end

  def product_search
    result = Product.where("lower(name) LIKE :query_string OR lower(description) LIKE :query_string OR lower(image_url) LIKE :query_string", {
      query_string: "%#{ sane_search_params[:queryString].downcase }%"
    })
    Rails.logger.debug "-------------------------------"
    Rails.logger.debug "Results: ( #{result.count} )"
    Rails.logger.debug "-------------------------------"
    result.each do |r|
      Rails.logger.debug "Search result: #{r.to_yaml}"
    end
    Rails.logger.debug "==============================="
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
