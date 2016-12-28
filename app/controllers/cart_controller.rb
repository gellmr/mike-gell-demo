require 'json'

class CartController < CartApplicationController

  def is_empty
    head :ok, { message: user_cart.count }
  end

  def index
    store_recent_url
    debug_print_cart()
    get_cart_products()
    # get_user_addresses()
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
    super
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
end
