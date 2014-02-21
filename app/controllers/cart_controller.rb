require 'json'

class CartController < ApplicationController

  def index
    # Get all products in the user's cart
    @products = []
    user_cart.each_with_index do |(productId,qty),index|
      Rails.logger.debug "productId:#{productId} qty:#{qty} index:#{index}"
      @products.push({
        record: Product.find(productId),
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
      user_cart[productId] = newQty;
      head :created # 201
    else
      # Send 403
      head :forbidden, {
        message: "Only #{product.quantityInStock} items available!",
        max: product.quantityInStock
      }
    end
  end

  private
    def handle_unverified_request
      # Bad CSRF token. The user session must have expired.
      head :unprocessable_entity # 422
    end
end
