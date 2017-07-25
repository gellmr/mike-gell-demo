class UserCustomerController < UserCustomerBaseController

  # User who is a customer.
  # This controller allows customers to edit their own details

  before_action :require_logged_in, except: [:create]

  # A new customer wants to create an account.
  # Recive form submission for the create.
  def create
    @customer = User.new(sane_user_params)
    if @customer.save
      puts "-----> Created Account successfully!!!"
      flash[:just_signed_up] = true;
      session[:current_user_id] = @customer.id
      render :json => @customer, :status => 201 # created
    else
      puts "-----> Failed to Create Account!!!"
      render :json => @customer.errors, :status => 400 # bad request
    end
  end

  # Customer wants to edit the basic details of his own account
  # Serve the edit form.
  def edit
    render locals: {
      user: User.find(params[:id])
    }
  end

  # Customer wants to update the basic details of his own account
  # Recive form submission for the update.
  def update
    @customer = User.find(params[:id])
    @customer.update_attributes!(sane_user_params)
    flash[:success] = "Successfully updated your details"
    logger.debug "Updated customer. params[:current_tab]: #{params[:current_tab]}"
    redirect_to edit_my_account_path(@customer)
  end

  # Customer wants to delete his own account.
  def destroy
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
      flash[:success] = "Successfully deleted your account. #{deletedCustomer}"
      #redirect_to manage_customers_path
    end
  end
end