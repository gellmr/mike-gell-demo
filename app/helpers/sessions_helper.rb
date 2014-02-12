module SessionsHelper
  def current_user
    @current_user ||= User.find(session[:current_user_id])
  end
end