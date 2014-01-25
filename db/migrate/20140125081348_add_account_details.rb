class AddAccountDetails < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    
    add_column :users, :home_phone, :string
    add_column :users, :work_phone, :string
    add_column :users, :mobile_phone, :string

    add_column :users, :shipping_address_line_1, :string
    add_column :users, :shipping_address_line_2, :string
    add_column :users, :shipping_address_city, :string
    add_column :users, :shipping_address_state, :string
    add_column :users, :shipping_address_post_code, :string
    add_column :users, :shipping_address_country_or_region, :string

    add_column :users, :billing_address_line_1, :string
    add_column :users, :billing_address_line_2, :string
    add_column :users, :billing_address_city, :string
    add_column :users, :billing_address_state, :string
    add_column :users, :billing_address_post_code, :string
    add_column :users, :billing_address_country_or_region, :string
  end
end
