class AddScaleToProductsDecimalFields < ActiveRecord::Migration
  def up
   change_column :products, :unitPrice, :decimal, precision: 7, :scale => 2
   change_column :products, :costFromSupplier, :decimal, precision: 7, :scale => 2
  end

  def down
   change_column :products, :unitPrice, :decimal
   change_column :products, :costFromSupplier, :decimal
  end
end
