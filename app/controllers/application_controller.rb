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

    def user_cart
      @_user_cart = session[:cart] ||= {}
    end

    def clear_cart
      @_user_cart = session[:cart] = {}
    end

    def require_logged_in
      unless current_user

        @message = "Please login first."
        if request.path == cart_submit_path
          @message = "You need to login before you can place an order."  
        end
        Rails.logger.debug @message
        flash[:warning] = @message

        respond_to do |format|
          format.js {
            head :unauthorized, {message: @message}
          }
          format.html {
            redirect_to login_path # halts request cycle 
          }
        end
      end
    end

    def debug_print_cart
      old_log_level = ActiveRecord::Base.logger.level
      ActiveRecord::Base.logger.level = 1

      if user_cart.empty?
        Rails.logger.info "-----------------------------"
        Rails.logger.info "   CART CONTENTS (EMPTY)"
        Rails.logger.info "-----------------------------"
      else
        Rails.logger.info "-----------------------------"
        Rails.logger.info "   CART CONTENTS"
        Rails.logger.info "-----------------------------"
        user_cart.each_with_index do |(productId,qty),index|
          p = Product.find(productId)
          Rails.logger.info "  Id:#{productId} Qty:#{qty}  #{p.name}"
        end
        Rails.logger.info "-----------------------------"
      end
      ActiveRecord::Base.logger.level = old_log_level
    end

    # Allows the view to access controller methods.
    helper_method :current_user, :destroy_session, :user_cart
end
