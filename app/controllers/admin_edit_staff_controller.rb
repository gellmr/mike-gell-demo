class AdminEditStaffController < AdminEditUserBaseController

  # This controller allows admin to edit staff details.

  # Admin wants to view a list of existing staff.
  def index
    #staff = User.where(usertype: "staff").

    # Admins can also edit other admins.
    staff = User.where('usertype=? OR usertype=?', 'staff', 'admin').
                  where.not(id: current_user.id).order(:email)

    render locals: {
      staff: staff
    }
  end

  # Admin wants to edit a staff
  def edit
    render locals: {
      user: User.find(params[:id])
    }
  end

  # Admin wants to update the details of a staff
  def update
    user = User.find(params[:id])
    user.update_attributes!(sane_user_params)
    flash[:success] = "Successfully updated user details"
    logger.debug "Updated staff. params[:current_tab]: #{params[:current_tab]}"
    redirect_to edit_staff_path(user)
  end
end
