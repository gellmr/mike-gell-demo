class CustomersController < UsersController

  def index
    @customers = User.where(usertype: "customer").
                      where.not(id: current_user.id).order(:email)
  end

  def edit
    @customer = User.find(params[:id])
  end

  def customer_addresses
    @user = User.find(params[:id])
    render "user_addresses/edit"
  end

  # Try to update an existing customer record.
  # Must be logged in
  def update
    @customer = User.find(params[:id])
    @customer.update_attributes!(sane_user_params)
    flash[:success] = "Successfully updated customer details"
    logger.debug "Updated customer. params[:current_tab]: #{params[:current_tab]}"

    if params[:current_tab] == 'customer_addresses'
      redirect_to customer_addresses_path(@customer)
    else
      redirect_to edit_customer_path(@customer)
    end
  end

end