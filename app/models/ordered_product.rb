class OrderedProduct < ActiveRecord::Base
  validates :order, :product, presence: true
  belongs_to :order     # gives us order_id   (FK)
  belongs_to :product   # gives us product_id (FK)
end
