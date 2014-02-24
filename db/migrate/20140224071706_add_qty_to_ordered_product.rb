class AddQtyToOrderedProduct < ActiveRecord::Migration
  def change
    add_column :ordered_products, :qty, :integer
  end
end
