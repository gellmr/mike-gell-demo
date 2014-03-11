
class PasswordResetController < ApplicationController

  def new
    Rails.logger.debug 'User wants to reset password. Serve the form'
  end

  def create
    Rails.logger.debug 'User has submitted a form, to reset their password.'
    Rails.logger.debug "email: #{params[:password_reset_email]}"
    
  end

end