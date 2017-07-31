class StaffEditCustomerController < StaffEditCustomerBaseController

  # This controller allows staff to edit customer details.

  # Staff wants to view a list of existing customers.
  def index
    @customers = User.where(usertype: "customer").
                      where.not(id: current_user.id).order(:email)
  end

  # Staff wants to edit the basic details of an existing customer.
  # Serve the edit form.
  def edit
    @customer = User.find(params[:id])
  end

  # Staff wants to update the basic details of an existing customer.
  # Recive form submission for the update.
  def update
    @customer = User.find(params[:id])
    @customer.update_attributes!(sane_user_params)
    flash[:success] = "Successfully updated customer details"
    logger.debug "Updated customer. params[:current_tab]: #{params[:current_tab]}"
    #redirect_to edit_customer_path(@customer)
  end

  # Staff wants to delete an existing customer.
  def destroy
    puts "DELETE CUSTOMER #{params[:id]}"
    @customer = User.find_by(id: params[:id])
    if @customer.nil?
      flash[:notice] = "Customer #{params[:id]} not found."
      #redirect_to manage_customers_path
    else
      if @customer.addresses.count > 0
        @customer.addresses.each do |address|
          address.destroy
        end
      end
      deletedCustomer = "#{@customer.id} (Name: #{@customer.first_name} #{@customer.last_name}, Email: #{@customer.email})."
      @customer.destroy
      flash[:success] = "Deleted Customer #{deletedCustomer}"
      puts "redirecting to customer list..."
      redirect_to staff_edit_customers_path
    end
  end
end