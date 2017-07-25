class StaffEditCustomerAddressController < StaffEditCustomerBaseController

  # This controller allows staff to edit customer addresses.

  # Staff wants to create a new address for an existing customer
  def create
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
    #redirect_to customer_addresses_path(@customer, anchor: "address#{address.id}")
  end

  # Staff wants to edit the addresses of an existing customer.
  # Serve the edit form.
  def edit
    @user = User.find(params[:id])
    #@form_submit_url = update_customer_path
    #render "user_addresses/edit"
  end

  # Staff wants to update the addresses of an existing customer.
  # Receive form submission for the update.
  def update
    @customer = User.find(params[:id])
    @customer.update_attributes!(sane_user_params)
    flash[:success] = "Successfully updated customer details"
    logger.debug "Updated customer. params[:current_tab]: #{params[:current_tab]}"
    #redirect_to customer_addresses_path(@customer)
  end

  # Staff wants to delete an address of an existing customer.
  def destroy
    @customer = User.find_by(id: params[:customer_id])
    address = @customer.addresses.find_by(id: params[:id])
    address.deleted = true
    address.save!
    #redirect_to customer_addresses_path(@customer)
  end
end