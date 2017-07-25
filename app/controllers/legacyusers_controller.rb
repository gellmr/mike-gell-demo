class UsersController < UsersBaseController

  before_action :require_staff, only: [:index]

  def index
    @users = User.where.not(id: current_user.id).order(:email)
  end

  def edit
    #@user = User.find_by(id: params[:id])
    @user = User.find(params[:id])
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

  # form submission to update this user's basic details
  def update
    @user = User.find(params[:id])
    @user.update_attributes!(sane_user_params)
    flash[:success] = "Successfully updated your details"
    logger.debug "Updated user. params[:current_tab]: #{params[:current_tab]}"
    redirect_to edit_user_path(@user)
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
end
