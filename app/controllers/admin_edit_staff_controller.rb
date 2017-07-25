class AdminEditStaffController < AdminEditUserBaseController

  # This controller allows admin to edit staff details.

  # Admin wants to view a list of existing staff.
  def index
    @staff = User.where(usertype: "staff").
                  where.not(id: current_user.id).order(:email)
  end
end
