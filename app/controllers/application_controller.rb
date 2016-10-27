class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  def get_user_addresses
    unless current_user.nil?
      @addresses = current_user.addresses.where(deleted: false).order(:id)

      # Make sure we have a shipping and billing address, initially selected. Use the 'default' address where possible. 
      if @addresses.count > 0
        gotShip, gotBill = false, false
        @addresses.each do |a|
          break if gotShip && gotBill
          if !gotShip
            gotShip = current_user.shipping_address == a.id
          end
          if !gotBill
            gotBill = current_user.billing_address == a.id
          end
        end
        if !gotShip
          current_user.shipping_address = @addresses.first.id
        end
        if !gotBill
          current_user.billing_address = @addresses.first.id
        end
      end

      logger.debug "User has #{@addresses.count} addresses:"
      logger.debug @addresses.to_yaml
    else
      logger.debug "User has NO addresses."
    end
  end

  private

    def destroy_session
      session[:current_user_id] = nil
      @_current_user = nil
    end

    # user related

    def current_user
      @_current_user ||= session[:current_user_id] && User.includes(:addresses).find_by(id: session[:current_user_id])
      if @_current_user && @_current_user.account_locked
        @_current_user = nil
      end
      @_current_user
    end

    def require_logged_in
      unless current_user

        @message = "Please login first."
        if request.path == cart_submit_path
          @message = "You need to login before you can place an order."  
        end
        Rails.logger.debug @message
        flash[:warning] = @message

        respond_to do |format|
          format.js {
            head :unauthorized, {message: @message}
          }
          format.html {
            redirect_to login_path # halts request cycle 
          }
        end
      end
    end

    def require_staff
      unless current_user && current_user.usertype == 'staff'
        redirect_to login_path # halts request cycle 
      end
    end

    # cart related

    def user_cart
      @_user_cart = session[:cart] ||= {}
    end

    def clear_cart
      @_user_cart = session[:cart] = {}
    end

    def debug_print_cart
      old_log_level = ActiveRecord::Base.logger.level
      ActiveRecord::Base.logger.level = 1

      if user_cart.empty?
        Rails.logger.info "-----------------------------"
        Rails.logger.info "   CART CONTENTS (EMPTY)"
        Rails.logger.info "-----------------------------"
      else
        Rails.logger.info "-----------------------------"
        Rails.logger.info "   CART CONTENTS"
        Rails.logger.info "-----------------------------"
        user_cart.each_with_index do |(productId,qty),index|
          p = Product.find(productId)
          Rails.logger.info "  Id:#{productId} Qty:#{qty}  #{p.name}"
        end
        Rails.logger.info "-----------------------------"
      end
      ActiveRecord::Base.logger.level = old_log_level
    end

    # Allows the view to access controller methods.
    helper_method :current_user, :destroy_session, :user_cart
end
