class UsersController < ApplicationController

  before_action :require_logged_in, except: [:create]
  before_action :require_staff, only: [:index, :edit_customer,:update_customer, :destroy]

  def index
    @users = User.where.not(id: current_user.id).order(:email)
  end

  def update_customer
    @customer = User.find(params[:id])
    @customer.update_attributes!(sane_user_params)
    flash[:success] = "Successfully updated Customer #{@customer.id}"
    logger.debug "Updated Customer #{@customer.id}. params[:current_tab]: #{params[:current_tab]}"

    if params[:current_tab].eql? 'customer_addresses'
      redirect_to customer_addresses_path(@customer)
    else
      redirect_to edit_customer_path(@customer)
    end
  end


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
    flash[:success] = "Successfully updated your details"
    logger.debug "Updated user. params[:current_tab]: #{params[:current_tab]}"

    if params[:current_tab] == 'user_addresses'
      redirect_to user_addresses_path(@user)
    else
      redirect_to edit_user_path(@user)
    end
  end

  # User has requested the 'my account' form.
  # Must be logged in
  def edit
    @user = User.find_by(id: params[:id])
    # Serve the 'my account' form.
  end

  # Staff wants to delete a user
  def destroy
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:notice] = "User #{params[:id]} not found."
      redirect_to manage_customers_path
    else
      if @user.addresses.count > 0
        @user.addresses.each do |address|
          address.destroy
        end
      end
      deletedUser = "#{@user.id} (Name: #{@user.first_name} #{@user.last_name}, Email: #{@user.email})."
      @user.destroy
      flash[:success] = "Deleted user #{deletedUser}"
      redirect_to manage_customers_path
    end
  end

  private
    # Strong params
    def sane_user_params
      params.require(:user).permit(
        :email,
        :password,
        :password_confirmation,
        :usertype,
        :first_name,
        :last_name,
        :home_phone,
        :work_phone,
        :mobile_phone,
        :shipping_address,
        :billing_address,
        addresses_attributes: [:id, :line_1, :line_2, :city, :state, :postcode, :country_or_region]
      )
    end
end
