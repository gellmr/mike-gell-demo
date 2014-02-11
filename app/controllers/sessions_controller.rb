require 'json'

class SessionsController < ApplicationController

  def create
    puts 'Try to find user by email... '
    puts "Email: #{params[:user][:email]}"

    user = User.find_by_email(params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      puts "-----> Authenticated successfully!!!"
      # Save the user ID in the session so it can be used in subsequent requests
      session[:current_user_id] = user.id
      # TODO: make a serialiser instead.
      render json: {user: {id: user.id}}, :status => 201 # created
    else
      puts "-----> Authentication failed!!!"
      head :bad_request # 400
    end
  end

  # "Delete" a login, aka "log the user out"
  def destroy
    # Remove the user id from the session
    puts "SessionsController#destroy ... session[#{session[:current_user_id]}] = nil"
    session[:current_user_id] = nil
    redirect_to root_url
  end

  # User wants to log in. Serve the login page.
  def login_page
    render template: "/layouts/loginPage"
  end

  # User wants to register. Serve the rego page.
  def register_page
    render template: "/layouts/registerPage"
  end

end