class TransactionsController < ApplicationController
  before_action :set_account, only: [:do_transaction]
  before_action :set_value, only: %i[do_transaction get_tax]
  before_action :transaction_name
  before_action :authenticate_active
  before_action :set_transaction, only: [:show]

  def index; end

  def show
    redirect_to account_path if current_user != @transaction.user
  end

  def transaction
    @transaction = Transaction.new
  end

  def get_tax
    respond_to do |format|
      format.json do
        render json: TaxCalculator.new(@value, Time.zone.now, params[:type_transaction], type_transfer).calc_tax
      end
    end
  end

  def tax
    TaxCalculator.new(@value, Time.zone.now, params[:type_transaction], type_transfer).calc_tax
  end

  def type_transfer
    if params[:type_transaction] == '3'
      2 # sender
    else
      1 # no_transfer
    end
  end

  def do_transaction
    @transaction = Transaction.new(
      account_id: @account_id,
      account_sender_id: current_user.id,
      account_recipient_id: params[:account_recipient].to_i,
      type_transaction: params[:type_transaction].to_i,
      type_transfer: type_transfer,
      tax: tax,
      value: @value,
      description: params[:description],
      date: Time.zone.now
    )

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to "/transactions/#{@transaction.id}" }
      else
        format.html { render :transaction }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def transfer; end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def set_account
    @account_id = current_user.accounts.first.id
  end

  def set_value
    @value = params[:value].to_f
  end

  def transaction_name
    type_transaction = params[:type_transaction]
    case type_transaction
    when '1'
      @transaction_type = 'sacar'
      @action_controller = 'do_transaction'
      @transaction_name = 'Saque'
    when '2'
      @transaction_type = 'depositar'
      @action_controller = 'do_transaction'
      @transaction_name = 'Depósito'
    else
      @transaction_type = 'transferir'
      @action_controller = 'do_transaction'
      @transaction_name = 'Transferência'
    end
  end
end
