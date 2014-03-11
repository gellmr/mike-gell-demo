
class PasswordResetController < ApplicationController

  def new
    Rails.logger.debug 'User wants to reset password. Serve the form'
  end

  def create
    # User has submitted email address, requesting password reset token be emailed to them.

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
    else
      # Valid email. Look up user...
      @user = User.find_by(email: email)
      if @user
        @user.password_reset_token = SecureRandom.urlsafe_base64
        PasswordResetMailer.pw_reset_token(@user).deliver
      else
        Rails.logger.debug("Could not find user by that email.")
      end
    end
  end
  
  def set_new
    # User has clicked their Password Reset Token (in their email inbox)
    token = sane_token_params[:token]
    email = sane_token_params[:email]
    Rails.logger.debug ("Received Password Reset Token: #{token} from email: #{email}")
    
    # Look up user by email
    @user = User.find_by(email: email)

    # Check if the token matches this user record
    if token == @user.password_reset_token
      # Token value is correct.
      if @user.locked_at > 10.minutes.ago
        # Token is fresh
        @user.account_locked = true # Overwrite any previous value.
        @user.locked_at = Time.now  # Overwrite any previous value.
        # SERVE FORM - LET USER SET A NEW PASSWORD (and confirm)
      else
        # Token has expired
        # Please request a new token.
      end
    else
      # Token does not match user email.
      # Token is invalid... perhaps you accidentally requested two tokens and are using the older one?
      # Please request a new token.
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

    # Strong params
    def sane_token_params
      params.permit(:token, :email)
    end
end