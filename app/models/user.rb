class User < ApplicationRecord
  belongs_to :role
  
  has_secure_password
  
  validates :username, presence: true, uniqueness: true
end
