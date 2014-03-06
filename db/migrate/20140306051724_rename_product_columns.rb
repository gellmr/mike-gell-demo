class RenameProductColumns < ActiveRecord::Migration
  def change
    rename_column :products, :imageUrl, :image_url
    rename_column :products, :unitPrice, :unit_price
    rename_column :products, :costFromSupplier, :cost_from_supplier
    rename_column :products, :quantityInStock, :quantity_in_stock
  end
end
