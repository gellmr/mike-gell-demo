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
    if sane_search_params[:query_string].blank?
      head :bad_request
    end

    Rails.logger.debug "\n\n"
    
    @products = []
    @grand_total = 0
    
    @all_products = Product.where("(name || description || image_url) ~* :pattern", {
      pattern: "#{product_regex}"
    }).order("name").page(params[:page]).per(3)

    Rails.logger.debug "\n-------------------------------"
    Rails.logger.debug "Search Results: ( #{@all_products.count} )"
    Rails.logger.debug "-------------------------------\n"

    @all_products.each_with_index do |product, i|
      Rails.logger.debug "\n(#{i}) #{product.name}"
      Rails.logger.debug "    #{product.description}"
      Rails.logger.debug "    #{product.image_url}\n"
      productId = product.id.to_s
      qty = user_cart[productId]
      @grand_total += subtot = product.unit_price * qty.to_i
      @products.push({
        record: product,
        cart_qty: qty,
        subtotal: nil
      })
    end
    Rails.logger.debug "==============================="
    render template: "/store/index"
  end

  # Construct a search string like '^(?=.*words)(?=.*in)(?=.*any)(?=.*order).+'
  # This regex uses "positive lookahead"
  # So, we can enter a search term: 'arduino pro arm7'
  # Which will match a product like this:
  # {
  #   name: 'blah arduino blah',    (matches 'arduino')
  #   description 'blah ARM7 blah', (matches 'arm' and '7')
  #   image_url: 'arduinoPro.jpg'   (matches 'arduino' and 'pro')
  # }
  # NOTE - ALL WORDS in the search string must occur for the product.
  # Otherwise the product does not appear in search results.
  # ----------------------------------------------------
  def product_regex
    # This process uses '%' characters to separate tokens.
    # Eg 'arduino pro arm7' becomes 'arduino%pro%arm%7'
    # ...then we split the string into an array: ['arduino', 'pro', 'arm', '7']
    # This allows us to construct a regex:
    # ^(?=.*arduino)(?=.*pro)(?=.*arm)(?=.*7).+

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

    # Word boundaries - when we get numbers and letters together, like "arm7"
    # we want a boundary between them. Eg, we want ['arm', '7']
    # The search string "cat677aaabbb ccc9aa-a-6" will be broken into:
    # ['cat', '677', 'aaabbb', 'ccc', '9', 'aa', 'a', '6']
    # And forms the following regex:
    # ^(?=.*cat)(?=.*677)(?=.*aaabbb)(?=.*ccc)(?=.*9)(?=.*aa)(?=.*a)(?=.*6).+
    
    out_query = ['^']
    s = sane_search_params[:query_string].downcase.strip
    s = s.gsub(/[^0-9a-z]/, '%')
    s = s.split(/([a-z%]+(?=[0-9 ]+))|([0-9%]+(?=[a-z ]+))/)
    s.reject! {|c| c.empty?}
    s = s.join('%')
    s = s.split('%')
    s.reject! {|c| c.empty?}

    s.each_with_index do |word, idx|
      out_query.push "(?=.*?#{word})" # use positive lookahead for each word in the search string.
    end
    out_query.push '.*$'

    Rails.logger.debug "product_regex: #{out_query.join}"
    out_query.join # returns '^(?=.*arduino)(?=.*pro)(?=.*arm)(?=.*7).+'
  end

  private
    # Strong params
    def sane_search_params
      params.permit(:query_string)
    end
end
