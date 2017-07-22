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

end