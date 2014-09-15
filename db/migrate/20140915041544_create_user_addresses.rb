class CreateUserAddresses < ActiveRecord::Migration
  def change
    create_table :user_addresses do |t|
      t.belongs_to :user
    end

    add_column :user_addresses, :line_1, :string
    add_column :user_addresses, :line_2, :string
    add_column :user_addresses, :city, :string
    add_column :user_addresses, :state, :string
    add_column :user_addresses, :postcode, :string
    add_column :user_addresses, :country_or_region, :string
  end
end
