require 'json'

class CartController < ApplicationController
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
end
