class AddDeletedToAddress < ActiveRecord::Migration
  def change
    add_column :user_addresses, :deleted, :boolean, default: false
  end
end
