class Transaction < ApplicationRecord
  belongs_to :account
  enum type_transaction: {withdraw: 1, deposit: 2, transfer: 3}

  validate :value_limits
  validates :value, numericality: { greater_than: 0 }

  after_save :update_amount_account

  def update_amount_account
    case self.type_transaction
    when 'deposit'
      self.account.update({:amount => self.account.amount+self.value})
    else
      self.account.update({:amount => self.account.amount-self.value-self.tax})
    end
  end

  def total
    self.value+self.tax
  end

  def transaction_money_moviment
    case self.type_transaction
    when 'deposit'
      return self.total
    else
      return -self.total
    end
  end

  def self.human_enum_name(enum_name, enum_value)
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.#{enum_name.to_s.pluralize}.#{enum_value}")
  end

private
  def value_limits
    if total > account.amount and type_transaction != "deposit"
      errors.add("Saldo", "insuficiente!")
    end
  end


end
