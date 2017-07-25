class UserBaseController < ApplicationController

  private
    # Strong params
    def sane_user_params
      params.require(:user).permit(
        :email,
        :password,
        :password_confirmation,
        :usertype,
        :first_name,
        :last_name,
        :home_phone,
        :work_phone,
        :mobile_phone,
        :shipping_address,
        :billing_address,
        addresses_attributes: [:id, :line_1, :line_2, :city, :state, :postcode, :country_or_region]
      )
    end
end