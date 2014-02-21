require 'json'

class CartController < ApplicationController
  # Make the session null if we get a bad CSRF token
  # This happens when the user session expires.
  # protect_from_forgery with: :null_session

  def index
    # Get all products in the user's cart
    #@cart_page = Cart.all
  end

  def update
    puts 'Try to update my cart...'

    if !current_user
      head :bad_request # 400
    end

    productId = params[:cartUpdate][:productId]
    newQty = params[:cartUpdate][:newQty]

    # Check if there are sufficient quantity in stock.
    product = Product.find(productId)
    if product.quantityInStock >= newQty.to_i
      session[productId] = newQty;
      head :created # 201
    else
      # Send 403
      head :forbidden, {
        message: "Only #{product.quantityInStock} items available!",
        max: product.quantityInStock
      }
    end
  end

  def handle_unverified_request
    # Bad CSRF token. The user session must have expired.
    head :unprocessable_entity # 422
  end
end
