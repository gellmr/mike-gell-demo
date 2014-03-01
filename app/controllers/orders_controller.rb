class OrdersController < ApplicationController

  before_action :require_logged_in, only: [:index, :show, :create]

  # Get all the orders for this user.
  # GET /users/:id/orders
  def index
    @orders = @user.orders
  end

  # Show the details of ONE order for this user.
  # GET /users/:id/orders/:order_id
  def show
    @order = @user.orders.find(params[:id])
  end

  # User has submitted their cart.
  # cart_submit_path
  # POST /cart/submit
  def create
    @order = Order.new
    @order.user = current_user
    if @order.save
      Rails.logger.debug "Order created successfully."
      head :created, {message: "Order created successfully", userId: current_user.id, orderId: @order.id}
    else
      Rails.logger.debug "Could not create order."
      head :bad_request, {message: "Could not create order"}
    end
  end

  private
    def require_logged_in
      unless current_user
        Rails.logger.debug "Must be logged in to place an order."
        flash[:warning] = "Must be logged in to place an order."
        
        head :bad_request, {message: "Must be logged in to place an order."}
        # redirect_to login_path # halts request cycle 
      end
    end
end