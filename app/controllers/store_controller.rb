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
    result = Product.where("lower(name) ~ :pattern OR lower(description) ~ :pattern OR lower(image_url) ~ :pattern", {
      pattern: "#{product_regex}"
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

  # Construct a search string like '^(?=.*words)(?=.*in)(?=.*any)(?=.*order).+'
  # This regex uses "positive lookahead"
  # So, we search can enter a search term: 'arduino pro arm7'
  # Which will match a product like this:
  # {
  #   name: 'blah arduino blah',    (matches 'arduino')
  #   description 'blah ARM7 blah', (matches 'ARM7')
  #   image_url: 'arduinoPro.jpg'   (matches 'arduino' and 'pro')
  # }
  # NOTE - ALL WORDS in the search string must occur or we get no match.
  # If we didn't have 'pro' somewhere in the product data, then the search would fail.
  # ----------------------------------------------------
  def product_regex
    out_query = ['^']
    # Replace non-alphanumeric characters with '%'
    # Eg 'arduino pro arm7' becomes 'arduino%pro%arm7'
    # Split into an array for processing, eg ['arduino', 'pro', 'arm7']
    sane_search_params[:queryString].downcase.strip.gsub(/[^0-9a-z]/i, '%').split('%').each do |word|
      out_query.push "(?=.*#{word})" # use positive lookahead for each word in the search string.
    end
    out_query.push '.+'

    Rails.logger.debug "product_regex: #{out_query.join}"

    out_query.join # returns "^(?=.*arduino)(?=.*pro)(?=.*arm7).+"

    # This will match if ALL TOKENS in the search string are present. (eg it uses -AND-)

    # This will match
    #   "blah arm7 arduino blah pro"
    #   "blah arm7 pro arduino"
    #   "pro arduino blah blah arm7"
    #   "arm7 arduino pro"
    #   "pro arm7 arduino"
    #   "blah arm7 blah pro arduino blah"

    # But will NOT match
    #   "arm7"
    #   "arduino arm7"
    #   "arduino pro"
    #   "arduino"
    #   "blah arduino blah"
  end

  private
    # Strong params
    def sane_search_params
      params.require(:productSearch).permit(
        :queryString
      )
    end
end
