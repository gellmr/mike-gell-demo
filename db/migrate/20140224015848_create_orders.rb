class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :user       # gives us user_id (FK)
      t.datetime :order_date
      t.timestamps
    end
  end
end
