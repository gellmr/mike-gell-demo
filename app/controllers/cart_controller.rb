require 'json'

class CartController < ApplicationController

  def index
    # Get all products in the user's cart
    debug_print_cart()
    @products = []
    @grand_total = 0
    @total_items = 0
    @total_lines = 0
    user_cart.each_with_index do |(productId,qty),index|
      @prod = Product.find(productId.to_s)
      @grand_total += subtot = @prod.unitPrice * qty.to_i
      @total_items += qty.to_i
      @total_lines += 1
      @products.push({
        record: @prod,
        cart_qty: qty,
        subtotal: subtot
      })
    end
  end

  def update
    puts 'Try to update my cart...'

    productId = params[:cartUpdate][:productId]
    newQty = params[:cartUpdate][:newQty]

    # Check if there are sufficient quantity in stock.
    product = Product.find(productId)
    if product.quantityInStock >= newQty.to_i

      # We have enough stock...

      if newQty.to_i == 0

        # User set qty to zero. Remove this item from cart
        user_cart.delete(productId)
        send_head_ok({
          result: "removed-from-cart",
          resultCartQty: 0,
          resultSubTot: 0,
          message: "Removed item from cart."
        })

      else
        if newQty.to_i > 0

          # User set qty to positive integer. Update cart quantity.
          user_cart[productId] = newQty;
          send_head_ok({
            result: "updated-qty",
            resultCartQty: newQty,
            resultSubTot: product.unitPrice * newQty.to_i,
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
      user_cart[productId] = product.quantityInStock;
      send_head_ok({
        result: "set-to-max",
        max: product.quantityInStock,
        resultCartQty: product.quantityInStock,
        resultSubTot: product.unitPrice * product.quantityInStock,
        message: "Only #{product.quantityInStock} items available!"
      })

    end
  end

  def destroy
    clear_cart()
    redirect_to action: 'index'
  end

  def submit
    # User has submitted their cart.
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
        @grand_total += @prod.unitPrice * qty.to_i
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
