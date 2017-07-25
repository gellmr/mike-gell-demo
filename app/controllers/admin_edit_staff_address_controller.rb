class AdminEditStaffAddressController < AdminEditUserBaseController

  # This controller allows admin to edit staff addresses.

  # Admin wants to edit the addresses of an existing staff.
  # Serve the edit form.
  def edit
    @staff = User.find(params[:id])
    #@form_submit_url = update_customer_path
    #render "user_addresses/edit"
  end
end