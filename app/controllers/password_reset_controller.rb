
class PasswordResetController < ApplicationController

  def new
    puts 'User wants to reset password. Serve the form'
  end

  def create
    puts 'User has submitted a form, to reset their password.'
  end

end