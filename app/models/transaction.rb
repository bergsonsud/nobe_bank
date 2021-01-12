class Transaction < ApplicationRecord
  belongs_to :account
  has_one :user, through: :account
  enum type_transaction: { withdraw: 1, deposit: 2, transfer: 3 }
  enum type_transfer: { no_transfer: 1, sent: 2, received: 3 }

  validate :value_limits, if: lambda {
                                type_transaction == 'withdraw' or (type_transaction == 'transfer' and type_transfer == 'sent')
                              }

  validate :account_recipient_exist, if: lambda {type_transaction == 'transfer' and type_transfer == 'sent'}
  validate :self_transfer, if: lambda {type_transaction == 'transfer' and type_transfer == 'sent'}

  validates :value, numericality: { greater_than: 0 }

  after_initialize :calc_tax
  after_save :update_sender_account

  # after_save :create_received_transaction
  after_save :update_recipient_account

  def create_received_transaction(type)
    if type == 'sent'
      Transaction.create(account_id: account_recipient_id,
                         account_sender_id: account_sender_id,
                         account_recipient_id: account_recipient_id,
                         type_transaction: 3,
                         type_transfer: 3,
                         tax: 0,
                         value: value,
                         description: description_transaction_received,
                         date: date)
    end
  end

  def description_transaction_received
    ''.concat('Transferência recebida de ', Account.find(account_sender_id).user.name,
              ' - Agência 001- Conta ', format('%06d', account_sender_id))
  end

  def update_sender_account
    case type_transaction
    when 'transfer'
      account.update({ amount: account.amount - value - tax })
      create_received_transaction(type_transfer)
    when 'withdraw'
      account.update({ amount: account.amount - value })
    else
      account.update({ amount: account.amount + value })
    end
  end

  def update_recipient_account
    case type_transaction
    when 'transfer'
      recepient_account = Account.find(account_recipient_id)
      recepient_account.update({ amount: recepient_account.amount + value })
    end
  end

  def calc_tax
    if type_transfer == 'sent'
      self.tax = TaxCalculator.new(value, date, type_transaction, type_transfer).calc_tax
    else
      0
    end
  end

  def total
    value + calc_tax
  end

  def transaction_money_moviment
    case type_transaction
    when 'deposit'
      total
    when 'transfer'
      if type_transfer == 'sent'
        -total
      else
        total
      end
    else
      -total
    end
  end

  def self.human_enum_name(enum_name, enum_value)
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.#{enum_name.to_s.pluralize}.#{enum_value}")
  end

  def recent
    Time.zone.now - created_at < 15
  end

  private

  def value_limits
    errors.add('Saldo', 'insuficiente!') if total > account.amount
  end

  def account_recipient_exist
    errors.add('Conta', 'inexistente!') if !User.exists? id: self.account_recipient_id
  end

  def self_transfer
    errors.add('Não', 'é permitido fazer trasnferência para sua própria conta!') if self.account_sender_id == self.account_recipient_id
  end
end
