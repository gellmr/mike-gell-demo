class PasswordResetMailer < ActionMailer::Base
  default from: ENV['EMAIL_ACCOUNT']

  def pw_reset_token(user, token)
    @user = user
    @token = token
    mail(
      to: @user.email,
      subject: 'Password Reset Token'
    )
  end
end