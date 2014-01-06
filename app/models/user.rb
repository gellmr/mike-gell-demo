class User < ActiveRecord::Base
  has_secure_password

  # validates_uniqueness_of :email

  validates :email, :password, :password_confirmation, presence: true

  validates :password, confirmation: true
  validates :password, length: { in: 10..32 }
  
  validates :email, length: { minimum: 5 }
  validates_uniqueness_of :email, :case_sensitive => false
end
