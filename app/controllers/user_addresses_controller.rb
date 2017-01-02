class UserAddressesController < ApplicationController

  before_action :require_staff, only: [:destroy_customer_address, :customer_create_address]

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

  # User wants the form for editing addresses
  def edit
    @user = User.find_by(id: params[:user_id])
  end

  # User wants to delete an address
  def destroy
    @user = User.find_by(id: params[:user_id])
    address = @user.addresses.find_by(id: params[:id])
    address.deleted = true
    address.save!
    redirect_to user_addresses_path(@user)
  end

  # Staff wants to create a new address for an existing customer
  def create_customer_address
    @customer = User.find_by(id: params[:customer_id])
    address = @customer.addresses.create(
      line_1: "Address line 1",
      line_2: "",
      city: "City",
      state: "State",
      postcode: "Postcode",
      country_or_region: "Country/Region"
    )
    address.line_1 = "Address##{address.id}"
    address.save!
    redirect_to customer_addresses_path(@customer, anchor: "address#{address.id}")
  end

  # Staff wants to delete an existing customer address
  def destroy_customer_address
    @customer = User.find_by(id: params[:customer_id])
    address = @customer.addresses.find_by(id: params[:id])
    address.deleted = true
    address.save!
    redirect_to customer_addresses_path(@customer)
  end

end