class OrdersController < ApplicationController

  before_action :require_logged_in, only: [:index, :show, :create]

  # Get all the orders for this user.
  # GET /users/:id/orders
  def index
    @orders = current_user.orders
  end

  # Show the details of ONE order for this user.
  # GET /users/:id/orders/:order_id
  def show
    @order = current_user.orders.find(params[:id])
  end

  # User has submitted their cart.
  # cart_submit_path
  # POST /cart/submit
  def create
    if place_order
      clear_cart()
      Rails.logger.debug "Order created successfully."
      flash[:success] = "Your order was created successfully."
      head :created, {message: "Order created successfully", userId: current_user.id, orderId: @order.id}
    else
      Rails.logger.debug "Could not create order."
      head :bad_request, {message: "Could not create order"}
    end
  end

  private

    def place_order
      all_valid = true
      @order = Order.new
      @order.user = current_user
      @order.order_date = Time.now

      op_arr = []
      user_cart.each_with_index do |(productId,qty),index|
        ordered_product = OrderedProduct.new
        ordered_product.order = @order
        ordered_product.product = Product.find(productId)
        ordered_product.qty = qty
        if ordered_product.valid?
          op_arr.push ordered_product # Don't save yet.
        else
          # This object is not valid. Exit the loop.
          all_valid = false
          break
        end
      end

      # Save the order, if all parts are valid.
      if all_valid && @order.valid?
        op_arr.each do |op|
          op.save!
          Rails.logger.debug "Created ordered_product #{op.id}"
        end
        @order.save!
        Rails.logger.debug "Created order #{@order.id}"
        return true # order created successfully.
      end
      false # failed to create order.
    end

    def require_logged_in
      unless current_user
        Rails.logger.debug "You must be logged in to place an order."
        flash[:warning] = "You must be logged in, to place an order."
        
        head :unauthorized, {message: "You must be logged in, to place an order."}
        # redirect_to login_path # halts request cycle 
      end
    end
end