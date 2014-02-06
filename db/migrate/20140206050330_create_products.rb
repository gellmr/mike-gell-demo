class CreateProducts < ActiveRecord::Migration
  def change

    create_table :products do |t|
      t.string  :name
      t.string  :description
      t.string  :imageUrl
      t.decimal :unitPrice
      t.decimal :costFromSupplier
      t.integer :quantityInStock
      t.timestamps
    end
    
    add_index :products, [:name, :description, :imageUrl]
  end
end
