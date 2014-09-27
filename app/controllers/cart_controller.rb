require 'json'

class CartController < ApplicationController

  def is_empty
    head :ok, { message: user_cart.count }
  end

  def index
    # Get all products in the user's cart
    debug_print_cart()
    @products = []
    @grand_total = 0
    @total_items = 0
    @total_lines = 0
    user_cart.each_with_index do |(productId,qty),index|
      @prod = Product.find(productId.to_s)
      @grand_total += subtot = @prod.unit_price * qty.to_i
      @total_items += qty.to_i
      @total_lines += 1
      @products.push({
        record: @prod,
        cart_qty: qty,
        subtotal: subtot
      })
    end
    @addresses = []

    if current_user.nil?
      logger.debug "User has NO addresses."
    end

    if !(current_user.nil?)
      # current_user.addresses.each do |a|
      #   @addresses.push({ id: a.id, line_1: a.line_1, city: a.city, state: a.state, country_or_region: a.country_or_region })
      # end
      @addresses = current_user.addresses.order(:id)
      logger.debug "User has #{current_user.addresses.count} addresses:"
      logger.debug @addresses.to_yaml
    end
  end

  def update
    puts 'Try to update my cart...'

    productId = params[:cartUpdate][:productId]
    newQty = params[:cartUpdate][:newQty]

    # Check if there are sufficient quantity in stock.
    product = Product.find(productId)
    if product.quantity_in_stock >= newQty.to_i

      # We have enough stock...

      if newQty.to_i == 0

        # User set qty to zero.
        user_cart.delete(productId)
        send_head_ok({
          result: "updated-qty",
          resultCartQty: 0,
          resultSubTot: 0,
          message: "Updated cart - set qty to zero."
        })

      else
        if newQty.to_i > 0

          # User set qty to positive integer. Update cart quantity.
          user_cart[productId] = newQty;
          send_head_ok({
            result: "updated-qty",
            resultCartQty: newQty,
            resultSubTot: product.unit_price * newQty.to_i,
            message: "Updated cart."
          })

        else
          
          # User set qty to negative integer. Remove from cart.
          user_cart.delete(productId)
          send_head_ok({
            result: "removed-from-cart",
            resultCartQty: 0,
            resultSubTot: 0,
            message: "Removed item from cart."
          })

        end
      end
    else

      # User wants more than we have available. Set to max available.
      user_cart[productId] = product.quantity_in_stock;
      send_head_ok({
        result: "set-to-max",
        max: product.quantity_in_stock,
        resultCartQty: product.quantity_in_stock,
        resultSubTot: product.unit_price * product.quantity_in_stock,
        message: "Only #{product.quantity_in_stock} items available!"
      })

    end
  end

  def destroy
    clear_cart()
    redirect_to action: 'index'
  end

  private
    def handle_unverified_request
      # Bad CSRF token. The user session must have expired.
      head :unprocessable_entity # 422
    end

    def send_head_ok hash_args
      head :ok, hash_args.merge({
        resultGrandTot: cart_grand_total,
        cartTotalItems: cart_total_items,
        cartTotalLines: cart_total_lines
      })
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
