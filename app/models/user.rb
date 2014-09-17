class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true
  validates :email, length: { minimum: 5 }
  validates_uniqueness_of :email, :case_sensitive => false
  has_many :orders
  has_many :user_addresses
  accepts_nested_attributes_for :user_addresses
end
