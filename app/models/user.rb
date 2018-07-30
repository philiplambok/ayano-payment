class User < ApplicationRecord
  belongs_to :role
  
  has_secure_password
  
  validates :username, presence: true, uniqueness: true

  def admin? 
    role_id == 1
  end

  def same?(another_user) 
    id == another_user.id
  end

  def owner_or_admin?(another_user) 
    admin? or same?(another_user)
  end
end
