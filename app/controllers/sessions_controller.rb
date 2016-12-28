require 'json'

class SessionsController < ApplicationController

  def create
    Rails.logger.debug 'Try to find user by email... '
    Rails.logger.debug "Email: #{params[:user][:email]}"
    user = User.find_by_email(params[:user][:email])

    if user && user.authenticate(params[:user][:password]) && (!user.account_locked)

      Rails.logger.debug "-----> Authenticated successfully!!! Create new session."

      clear_and_retain_cart

      # Save the user ID in the session so it can be used in subsequent requests
      session[:current_user_id] = user.id

      flash[:success] = "You are now logged in as #{current_user.email}"

      # Tell the client where to go now they are logged in.
      # The client page has some ajax waiting to receive json from us, telling 'you are logged in, please navigate to xyz url'
      # We do this instead of performing a redirect on the server side.
      destination_url = get_login_destination

      # destination_url:      http://localhost:3000/checkout/submit
      # checkout_submit_path: /checkout/submit
      # checkout_path:        /checkout

      if destination_url == checkout_submit_path
        # The user tried to go thru checkout.
        # Take them back to the checkout once the login is completed.
        destination_url = checkout_path
      end

      # Now we just send some json back to the javascript on the login page, and let it make another request, rather than doing a redirect.
      # TODO: make a serialiser instead.
      render json: {redirection: destination_url, user: {id: user.id}}, :status => 201 # created

      # The user has successfully logged in.
    else
      logger.debug "-----> Authentication failed!!!"
      if (user && user.account_locked)
        head :bad_request, { message: "Your account has been locked. Please follow the steps listed under 'Forgot my password'" } # 400
      else
        head :bad_request, { message: "Invalid login details." } # 400
      end
    end
  end

  # "Delete" a login, aka "log the user out"
  def destroy
    # Remove the user id from the session
    Rails.logger.debug "SessionsController#destroy ... session[#{session[:current_user_id]}] = nil"
    reset_session # Help prevent session fixation attack.
    destroy_session
    Rails.logger.debug "Session has been destroyed and reset. Redirecting now..."
    render template: "/login_logout/successfullyLoggedOut"
  end

  # User wants to log in. Serve the login page.
  def login_page
    render template: "/login_logout/login_page"
  end

  # User wants to register. Serve the rego page.
  def register_page
    render template: "/register/registerPage"
  end

  # The user's session has expired
  # This controller action will render a page telling them what happened.
  # Javascript has directed the user to this page.
  def expired_notice
    render template: "/session/sessionExpired"
  end

  private
    def clear_and_retain_cart
      # Clear the session, except for the user cart and other session vars that we want to retain.
      # It would be a big inconvenience for the user if they lost all their cart when they log in.
      # I need to read about "session fixation attack" and security and stuff, and see if this code needs some attention.
      # Is it a 'security best practice' to clear the session on login?
      # Does this actually prevent 'session fixation attack' or other attacks?

      temp_cart = {}
      user_cart.each_with_index do |(productId,qty),index|
        quantity = qty.to_i
        @prod = Product.find(productId.to_s)
        if @prod.quantity_in_stock >= quantity
          temp_cart[productId] = quantity # get the number requested.
        else
          temp_cart[productId] = @prod.quantity_in_stock # get as many as are available.
        end
      end
      retain_forwarding_url = session[:forwarding_url]
      retain_recent_url = session[:recent_url]

      Rails.logger.debug "Clear session."
      reset_session # Clears to an empty hash.
      clear_cart
      debug_print_cart

      Rails.logger.debug "Restore cart contents for user convenience..."
      user_cart.replace(temp_cart) # copy each hash value into the new session.
      debug_print_cart

      # im sure there must be better way to do this.
      session[:forwarding_url] = retain_forwarding_url
      session[:recent_url] = retain_recent_url
    end
end