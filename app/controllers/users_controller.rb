class UsersController < ApplicationController

  def create
    @user = User.new(sane_user_params)
    if @user.save
      puts "-----> Created Account successfully!!!"
      flash[:just_signed_up] = true;
      session[:current_user_id] = @user.id
      render :json => @user, :status => 201 # created
    else
      puts "-----> Failed to Create Account!!!"
      render :json => @user.errors, :status => 400 # bad request
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes!(sane_user_params)
    redirect_to @user
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  private
    def sane_user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
