class User < ApplicationRecord
  belongs_to :role
  
  has_secure_password
  has_one :deposit
  has_many :logs
  
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

  def add_deposit(options)
    deposit.amount += options[:amount].to_i
    deposit.save
    logs.create(message: "You added deposit #{options[:amount]}") if options[:log]
  end

  def take_deposit(options)
    deposit.amount -= options[:amount].to_i
    deposit.save
    logs.create(message: "You take deposit #{options[:amount]}") if options[:log]
  end

  def take_deposit?(amount) 
    deposit.amount >= amount.to_i
  end

  def transfer(options)
    take_deposit({amount: options[:amount]})
    options[:to].add_deposit({amount: options[:amount]})
    logs.create(message: "You send #{options[:amount]} to #{options[:to].username}")
  end
end
