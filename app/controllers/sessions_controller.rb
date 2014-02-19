require 'json'

class SessionsController < ApplicationController

  def create
    puts 'Try to find user by email... '
    puts "Email: #{params[:user][:email]}"
    user = User.find_by_email(params[:user][:email])

    if user && user.authenticate(params[:user][:password])

      temp_session = session.dup # Make a shallow copy of session
      reset_session # Prevent session fixation attack. Clears to an empty hash.

      # session.replace(temp_session) # copy each hash value into the new session.

      # This is all accomplished by session.replace
      # session[:athlete_id] = athlete.id # re-populate each var
      # session[:cart_thing] = cart_thing # re-populate each var
      # session[:etc]        = etc        # re-populate each var

      puts "-----> Authenticated successfully!!!"

      # Save the user ID in the session so it can be used in subsequent requests
      session[:current_user_id] = user.id

      # TODO: make a serialiser instead.
      render json: {user: {id: user.id}}, :status => 201 # created

      # The user has successfully logged in.
    else
      puts "-----> Authentication failed!!!"
      head :bad_request # 400
    end
  end

  # "Delete" a login, aka "log the user out"
  def destroy
    # Remove the user id from the session
    Rails.logger.debug "SessionsController#destroy ... session[#{session[:current_user_id]}] = nil"
    reset_session # Help prevent session fixation attack.
    destroy_session
    Rails.logger.debug "Session has been destroyed and reset. Redirecting now..."
    render template: "/layouts/successfullyLoggedOut"
  end

  # User wants to log in. Serve the login page.
  def login_page
    render template: "/layouts/loginPage"
  end

  # User wants to register. Serve the rego page.
  def register_page
    render template: "/layouts/registerPage"
  end

  private
    def destroy_session
      session[:current_user_id] = nil
      @current_user = nil
    end
end