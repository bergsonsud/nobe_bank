class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :accounts
  has_many :transactions, through: :accounts

  after_create :create_account


  def create_account
    Account.create(user_id: self.id, amount: 0)
  end
end
