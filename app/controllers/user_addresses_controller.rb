class UserAddressesController < ApplicationController

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
    redirect_to edit_user_path(@user, anchor: "address#{address.id}")
  end

  # User wants to delete an address
  def destroy
    @user = User.find_by(id: params[:user_id])
    address = @user.addresses.find_by(id: params[:id])
    address.destroy!
    redirect_to edit_user_path(@user, anchor: "myAddresses")
  end

end