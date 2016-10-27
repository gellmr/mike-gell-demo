class CheckoutController < CartApplicationController

  def index
    get_cart_products()
    get_user_addresses()
  end

end
