class UserAddress < ActiveRecord::Base
  belongs_to :user, inverse_of: :addresses

  def oneLine
    "#{line_1}, #{city} #{state} #{postcode} #{country_or_region}"
  end
end
