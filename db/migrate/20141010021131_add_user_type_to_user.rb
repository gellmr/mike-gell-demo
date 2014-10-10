class AddUserTypeToUser < ActiveRecord::Migration
  def change
    add_column :users, :usertype, :string, default: 'customer'
  end
end
