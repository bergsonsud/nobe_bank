class Transaction < ApplicationRecord
  belongs_to :account
  enum type_transaction: {withdraw: 1, deposit: 2, transfer: 3}

  after_save :update_amount_account

  def update_amount_account
    case self.type_transaction
    when 'deposit'
      self.account.update({:amount => self.account.amount+self.value})
    else
      self.account.update({:amount => self.account.amount-self.value})
    end
  end
end
