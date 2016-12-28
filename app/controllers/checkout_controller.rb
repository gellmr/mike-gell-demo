class CheckoutController < CartApplicationController

  def index
    store_recent_url
    get_cart_products()
    get_user_addresses()
  end

end
