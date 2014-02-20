class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  private
 
    def current_user
      @_current_user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
    end

    def destroy_session
      session[:current_user_id] = nil
      @_current_user = nil
    end

    helper_method :current_user, :destroy_session
end
