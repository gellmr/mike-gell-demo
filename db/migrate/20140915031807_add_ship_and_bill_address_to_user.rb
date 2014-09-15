class AddShipAndBillAddressToUser < ActiveRecord::Migration
  def change
    add_column :users, :shipping_address, :integer
    add_column :users, :billing_address, :integer
  end
end