class UsersController < ApplicationController

  before_action :require_login, only: [:update, :show]

  # Try to register a new user account.
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

  # Try to update an existing user account.
  # Must be logged in
  def update
    @user = User.find(params[:id])
    @user.update_attributes!(sane_user_params)
    redirect_to @user
  end

  # Show my account details.
  # Must be logged in
  def show
    @user = User.find_by(id: params[:id])
  end

  private
    # Strong params
    def sane_user_params
      params.require(:user).permit(
        :email,
        :password,
        :password_confirmation,
        :first_name,
        :last_name,
        :home_phone,
        :work_phone,
        :mobile_phone
      )
    end

    # Before action
    def require_login
      unless current_user
        flash[:warning] = "Please login first."
        redirect_to login_path # halts request cycle
      end
    end
end
