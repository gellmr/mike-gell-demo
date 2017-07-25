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

  def get_login_destination
    # once logged in...
    # Go to where i was trying to get to. If there is a forwarding url then we will use it.
    redirection = get_forwarding_url
    if ! redirection.nil?
      return redirection
    end

    # Or, go to where i just was.
    # It only remembers certain pages like Store, Cart, and Checkout, ...not pages like Register and Login.
    # Please just use store_recent_url in the controller index action, to remember a page in this way.
    redirection = get_recent_url
    if ! redirection.nil?
      return redirection
    end

    # or, by default go to the account page
    redirection ||= "/user_customer/#{current_user.id}" # My Account
    return redirection
  end

  # Stores the page we were just on, in case the application logic wants to go back there in the near future.
  # The 'recent url' is meant for redirecting the user to a non-restricted url, after they successfully log in.
  # The 'recent url' is also meant for redirecting the user back to 'where i just was' if the application logic needs to.
  def store_recent_url
    session[:recent_url] = request.original_fullpath
    Rails.logger.debug "store_recent_url() session[:recent_url]: #{session[:recent_url]}"
  end

  def get_recent_url
    url = session[:recent_url]
    session.delete(:recent_url)
    return url
  end

  # Stores the URL trying to be accessed.
  # Eg, if we try to checkout when not logged in, we are prompted to login, and then directed back to the 'forwarding url'.
  # The 'forwarding url' is meant for redirecting the user to a restricted url, after they successfully log in.
  def store_forwarding_url
    Rails.logger.debug "Store forwarding url: #{request.original_fullpath}"
    session[:forwarding_url] = request.original_fullpath
  end

  def get_forwarding_url
    url = session[:forwarding_url]
    session.delete(:forwarding_url)
    return url
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

        store_forwarding_url

        @message = "Please login first."
        Rails.logger.debug "#{@message} request.path: #{request.path}"
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

    # Makes the controller methods available to the View
    helper_method :current_user, :destroy_session, :user_cart
end
