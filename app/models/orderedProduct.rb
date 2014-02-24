class OrderedProduct < ActiveRecord::Base
  belongs_to :order     # gives us order_id   (FK)
  belongs_to :product   # gives us product_id (FK)
end
