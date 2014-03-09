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
  end

  def product_search
    if sane_search_params[:query_string].blank?
      Rails.logger.debug "query string was blank."      
      redirect_to :store_index and return
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

  # Construct a search string like:
  # ^(?=.*?words)(?=.*?in)(?=.*?any)(?=.*?order).*$
  # This regex uses positive lookahead to tell if the string has all the words we ask for.
  # Each positive lookahead is of the form:
  # (?=.*?word)
  # The ?= part means it is a positive lookahead.
  # The .*? means 'anything any number of times, or - nothing at all'
  # If we run   ^(?=.*?word).*$   against blahblahwordblah it will return true
  # Similarly if we run  ^(?=.*?word)(?=.*?anotherword).*$  against  xxxanotherwordyyywordxx
  # it will also return true. The order of words is not important.
  # However, if we run    ^(?=.*?word)(?=.*?anotherword).*$   against  xxxwordxxx
  # then it will return false because the 'anotherword' part is not found.
  # 
  # So, we can enter a search term: 'arduino pro arm7'
  # Which will match a product like this:
  # {
  #   name: 'armite pro',           (matches 'pro')
  #   description 'arm7 cpu',       (matches 'arm' and '7')
  #   image_url: 'arduinoPro.jpg'   (matches 'arduino' and 'pro')
  # }
  # The search works by concatenating name, description, and image_url into one string.
  # The regex is run against the string, and returns true if all terms are present.
  # So for the above, we would be matching   ^(?=.*?arduino)(?=.*?pro)(?=.*?arm)(?=.*?7).*$
  # against...
  # "armite proarm7 cpuarduinoPro.jpg"
  #         ^  ^  ^    ^      ^
  # ----------------------------------------------------
  def product_regex
    # Word boundaries - when we get numbers and letters together, like "arm7"
    # we want a boundary between them. Eg, we want ['arm', '7']
    # The search string "cat677aaabbb ccc9aa-a-6" will be broken into:
    # ['cat', '677', 'aaabbb', 'ccc', '9', 'aa', 'a', '6']
    # And forms the following regex:
    #    ^(?=.*?cat)(?=.*?677)(?=.*?aaabbb)(?=.*?ccc)(?=.*?9)(?=.*?aa)(?=.*?a)(?=.*?6).*$
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
    out_query.join # returns regex as string.
  end

  private
    # Strong params
    def sane_search_params
      params.permit(:query_string)
    end
end
