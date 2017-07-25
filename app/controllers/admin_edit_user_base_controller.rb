class AdminEditUserBaseController < UserBaseController

  # Admin user who is editing all other kinds of user.

  before_action :require_admin
  
end