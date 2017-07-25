class UserAddressesController < ApplicationController

  before_action :require_staff, only: [:destroy_customer_address, :customer_create_address]

  # User wants the form for editing addresses
  def edit
    @user = User.find_by(id: params[:user_id])
  end

  # User wants to add a new address
  def create
    @user = User.find_by(id: params[:user_id])
    address = @user.addresses.new
    address.line_1 = "address line 1"
    address.line_2 = "address line 2"
    address.city = "city"
    address.state = "state"
    address.postcode = "postcode"
    address.country_or_region = "country or region"
    address.save!
    redirect_to user_addresses_path(@user, anchor: "address#{address.id}")
  end

  # form submission to update this user's addresses
  def update
    @user = User.find(params[:id])
    @user.update_attributes!(sane_user_params)
    flash[:success] = "Successfully updated your details"
    logger.debug "Updated user. params[:current_tab]: #{params[:current_tab]}"
    redirect_to user_addresses_path(@user)
  end

  # User wants to delete an address
  def destroy
    @user = User.find_by(id: params[:user_id])
    address = @user.addresses.find_by(id: params[:id])
    address.deleted = true
    address.save!
    redirect_to user_addresses_path(@user)
  end
end