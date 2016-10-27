class CartApplicationController < ApplicationController
  
  def destroy
    clear_cart()
  end

  private

    def get_cart_products
      @products = []
      @grand_total = 0
      @total_items = 0
      @total_lines = 0
      user_cart.each_with_index do |(productId,qty),index|
        @prod = Product.find(productId.to_s)
        @grand_total += subtot = @prod.unit_price * qty.to_i
        @total_items += qty.to_i
        @total_lines += 1
        @products.push({ record: @prod, cart_qty: qty, subtotal: subtot })
      end
    end

    def cart_grand_total
      @grand_total = 0
      user_cart.each_with_index do |(productId,qty),index|
        @prod = Product.find(productId.to_s)
        @grand_total += @prod.unit_price * qty.to_i
      end
      @grand_total
    end

    def cart_total_items
      @cart_total_items = 0
      user_cart.each_with_index do |(productId,qty),index|
        @cart_total_items += qty.to_i
      end
      @cart_total_items
    end

    def cart_total_lines
      @cart_total_lines = 0
      user_cart.each do | p |
        @cart_total_lines += 1
      end
      @cart_total_lines
    end

end
