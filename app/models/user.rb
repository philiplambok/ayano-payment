class User < ApplicationRecord
  belongs_to :role
  
  has_secure_password
  has_one :deposit
  
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

  def open_deposit!
    deposit = Deposit.create(user: self, amount: 0)
  end

  def add_deposit(amount) 
    deposit.amount += amount.to_i
    deposit.save 
  end

  def take_deposit(amount) 
    deposit.amount -= amount.to_i
    deposit.save
  end

  def take_deposit?(amount) 
    deposit.amount >= amount.to_i
  end

  def transfer(options)
    take_deposit(options[:amount])
    options[:to].add_deposit(options[:amount])
  end
end
