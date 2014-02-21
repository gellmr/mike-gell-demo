require 'json'

class CartController < ApplicationController

  def index
    # Get all products in the user's cart
    debug_print_cart()
    @products = []
    user_cart.each_with_index do |(productId,qty),index|
      @products.push({
        record: Product.find(productId.to_s),
        cart_qty: qty
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
        head :ok, {
          result: "removed-from-cart",
          resultCartQty: 0,
          message: "Removed item from cart."
        }

      else
        if newQty.to_i > 0

          # User set qty to positive integer. Update cart quantity.
          user_cart[productId] = newQty;
          head :ok, {
            result: "updated-qty",
            resultCartQty: newQty,
            message: "Updated cart."
          }

        else
          
          # User set qty to negative integer. Remove from cart.
          user_cart.delete(productId)
          head :ok, {
            result: "removed-from-cart",
            resultCartQty: 0,
            message: "Removed item from cart."
          }

        end
      end
    else

      # User wants more than we have available. Set to max available.
      user_cart[productId] = product.quantityInStock;
      head :ok, {
        result: "set-to-max",
        max: product.quantityInStock,
        resultCartQty: product.quantityInStock,
        message: "Only #{product.quantityInStock} items available!"
      }

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
end
