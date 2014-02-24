class OrdersController < ApplicationController

  before_action :lookup_user, only: [:index, :show]

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

  private
    def lookup_user
      @user = User.find(params[:user_id])
    end
end