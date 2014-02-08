class Product < ActiveRecord::Base

  validates :name, presence: true

  validates :name, length: { minimum: 3 }

  validates_uniqueness_of :name, :case_sensitive => false
end
