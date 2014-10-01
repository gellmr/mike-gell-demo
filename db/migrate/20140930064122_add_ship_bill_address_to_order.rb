class AddShipBillAddressToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :shipping_address, :integer
    add_column :orders, :billing_address, :integer
  end
end
