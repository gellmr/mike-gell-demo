class RemoveAddressLinesFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :shipping_address_line_1
    remove_column :users, :shipping_address_line_2
    remove_column :users, :shipping_address_city
    remove_column :users, :shipping_address_state
    remove_column :users, :shipping_address_post_code
    remove_column :users, :shipping_address_country_or_region

    remove_column :users, :billing_address_line_1
    remove_column :users, :billing_address_line_2
    remove_column :users, :billing_address_city
    remove_column :users, :billing_address_state
    remove_column :users, :billing_address_post_code
    remove_column :users, :billing_address_country_or_region
  end
end
