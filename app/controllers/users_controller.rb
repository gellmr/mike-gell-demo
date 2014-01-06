class UsersController < ApplicationController

  def create
    @user = User.new(sane_user_params)
    # Try to validate the new user record
    if @user.save
      render :json => @user, :status => 201 # created
    else
      render :json => @user.errors.messages, :status => 400 # bad request
    end
  end

  private
    def sane_user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
