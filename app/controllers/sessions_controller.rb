require 'json'

class SessionsController < ApplicationController

  def create
    logger.debug 'Try to find user by email... '
    logger.debug "Email: #{params[:user][:email]}"
    user = User.find_by_email(params[:user][:email])

    if user && user.authenticate(params[:user][:password]) && (!user.account_locked)

      Rails.logger.debug "Create new session."

      # Retain cart, if the user has only just logged in.
      # Note - it would be inconvenient for the user if they lost all their cart when they log in.
      # But clearing the session on login is 'security best practice'
      # Not sure if this is a major security issue... Needs attention.
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
      Rails.logger.debug "Clear session, to prevent session fixation attack..."
      reset_session # Clears to an empty hash.
      clear_cart
      debug_print_cart

      Rails.logger.debug "Restore cart contents for user convenience..."
      user_cart.replace(temp_cart) # copy each hash value into the new session.
      debug_print_cart

      logger.debug "-----> Authenticated successfully!!!"

      # Save the user ID in the session so it can be used in subsequent requests
      session[:current_user_id] = user.id

      flash[:success] = "You are now logged in as #{current_user.email}"
      redirection = "/cart" # My Cart
      if user_cart.empty?
        redirection = "/users/#{user.id}/edit" # My Account
      end

      # TODO: make a serialiser instead.
      render json: {redirection: redirection, user: {id: user.id}}, :status => 201 # created

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
    render template: "/login_logout/loginPage"
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

end