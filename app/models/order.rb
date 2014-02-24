class Order < ActiveRecord::Base
  validates :user, presence: true
  belongs_to :user # gives us user_id (FK)
  has_many :ordered_products, dependent: :destroy
  has_many :products, through: :ordered_products
end
