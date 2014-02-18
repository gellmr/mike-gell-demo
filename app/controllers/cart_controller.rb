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
    productId = params[:cartUpdate][:productId]
    newQty = params[:cartUpdate][:newQty]

    puts "-----> Authentication failed!!!"
    head :bad_request # 400
  end

  def handle_unverified_request
    # Bad CSRF token. The user session must have expired.
    head :unprocessable_entity # 422
  end
end
