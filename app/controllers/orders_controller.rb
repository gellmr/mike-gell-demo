class OrdersController < ApplicationController

  before_action :require_logged_in, except: []

  # Get all the orders for this user.
  # GET /users/:id/orders
  def index
    @orders = current_user.orders
    @ship_addresses = {}
    @bill_addresses = {}
    @orders.each do | order |
      @ship_addresses[order.id] = current_user.addresses.find_by_id(order.shipping_address)
      @bill_addresses[order.id] = current_user.addresses.find_by_id(order.billing_address)
    end
  end

  # Show the details of ONE order for this user.
  # GET /users/:id/orders/:order_id
  def show
    @order = current_user.orders.find(params[:id])
    @shipping_address = current_user.addresses.find_by_id(@order.shipping_address)
    @billing_address = current_user.addresses.find_by_id(@order.billing_address)
  end

  def create
    puts "TRY TO CREATE AN ORDER..."
    if ! current_user.addresses.any?
      puts "user has got no addresses."

      # tell client javascript to redirect to addresses page.
      flashMessage = "You don't have any Shipping Address or Billing Address. Please add them"
      flash.keep
      flash[:danger] = flashMessage
      json = {
        userId: current_user.id,
        redirect: edit_my_addresses_path(current_user),
        flashMessage: flashMessage
      }
      render :json => json, :status => 400 # bad request
    else

      puts "user has got an address"

      if place_order
        clear_cart()
        puts "Order created successfully."
        flash[:success] = "Your order was created successfully."
        head :created, {message: "Order created successfully", userId: current_user.id, orderId: @order.id}
      else
        Rails.logger.debug "Could not create order. #{@order.errors.full_messages}"
        if @order.errors.any?
          flashMessage = @order.errors.to_s
          flash.keep
          flash[:danger] = flashMessage
          json = {
            userId: current_user.id,
            flashMessage: flashMessage
          }
        end
        render :json => json, :status => 400 # bad request
      end
    end
  end

  private

    def place_order
      all_valid = true
      @order = Order.new
      @order.order_status = "Not Shipped Yet"
      @order.user = current_user
      @order.order_date = Time.now
      @order.shipping_address = params[:shippingRadioOptions]
      @order.billing_address = params[:billingRadioOptions]

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
end