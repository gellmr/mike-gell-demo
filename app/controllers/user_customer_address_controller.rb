class UserCustomerAddressController < UserCustomerBaseController

  # User who is a customer.
  # This controller allows customers to edit their own addresses

  before_action :require_logged_in

  # Customer wants to create a new address
  def create
    @customer = User.find_by(id: current_user.id)
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
    redirect_to edit_my_addresses_path(@customer, anchor: "address#{address.id}")
  end

  # Customer wants to edit his existing addresses.
  # Serve the edit form.
  def edit
    render locals: {
      user: User.find(params[:id])
    }
  end

  # Customer wants to update his existing addresses
  # Receive form submission for the update.
  def update
    @customer = User.find(params[:id])
    @customer.update_attributes!(sane_user_params)
    flash[:success] = "Successfully updated your details"
    logger.debug "Updated customer. params[:current_tab]: #{params[:current_tab]}"
    #redirect_to customer_addresses_path(@customer)
  end

  # Customer wants to delete one of his existing addresses
  def destroy
    puts "try to delete address... current_user.id:#{current_user.id}"
    @customer = User.find_by(id: params[:id])
    address = @customer.addresses.find_by(id: params[:format])
    address.deleted = true
    address.save!
    puts "Successfully!"
    redirect_to edit_my_addresses_path(@customer)
  end
end