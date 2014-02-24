class CreateOrderedProducts < ActiveRecord::Migration
  def change
    create_table :ordered_products do |t|
      t.belongs_to :order     # gives us order_id   (FK)
      t.belongs_to :product   # gives us product_id (FK)
    end
  end
end
