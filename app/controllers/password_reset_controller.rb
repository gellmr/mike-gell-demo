
class PasswordResetController < ApplicationController

  def new
    Rails.logger.debug 'User wants to reset password. Serve the form'
  end

  def create
    email = sane_params[:email].downcase
    Rails.logger.debug "email.downcase: #{email}"

    # Informative logging
    if email.blank?
      Rails.logger.debug "(validation fail) Email is blank"
    end
    if email == "your email address"
      Rails.logger.debug "(validation fail) Email is placeholder string"
    end

    if email.blank? || email == "your email address" || !valid_email?(email)
      flash[:warning] =  'Please provide a valid email address.'
      redirect_to new_password_reset_path
    end
  end
  
  private
    # see http://www.regular-expressions.info/email.html
    def valid_email?(email_string)
      regex = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
      if ( email_string =~ regex ) != nil
        Rails.logger.debug "(validation PASS) email regex)"
        return true
      else
        Rails.logger.debug "(validation fail) email regex)"
        return false
      end
    end

    # Strong params
    def sane_params
      params.permit(:email)
    end
end