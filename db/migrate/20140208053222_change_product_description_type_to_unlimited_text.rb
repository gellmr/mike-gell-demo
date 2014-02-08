class ChangeProductDescriptionTypeToUnlimitedText < ActiveRecord::Migration
  def up
    change_column :products, :description, :text
  end
  def down
      # This might cause trouble if you have strings longer
      # than 255 characters.
      change_column :products, :description, :string
  end
end
