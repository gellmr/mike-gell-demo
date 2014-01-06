class UsersController < ApplicationController

  def create
    @user = User.new(sane_user_params)
    # Try to validate the new user record
    if @user.save
      render :json => @user, :status => 201
    else
      head :bad_request
    end
  end

  private
    def sane_user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
