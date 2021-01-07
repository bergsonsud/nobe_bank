class TransactionsController < ApplicationController

  before_action :set_account, only: [:do_transaction]
  before_action :set_tax, only: [:do_transaction]
  before_action :set_value, only: [:do_transaction]
  before_action :transaction_name



  def index
  end

  def transaction
  end

  def do_transaction
    @transaction = Transaction.new(
      :account_id => @account_id,
      :type_transaction => params[:type_transaction].to_i,
      :tax => @tax,
      :value => @value,
      :description => params[:description],
      :date => Date.parse(params[:date]))

    respond_to do |format|
      if @transaction.save
        format.json { head :no_content }
        format.html
      else
        format.json { render json: @transaction.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def transfer
  end

private
  def set_account
      @account_id = current_user.accounts.first.id
  end

  def set_tax
    @tax = 0
  end

  def set_value
    @value = params[:value].to_f
  end


  def transaction_name
    type_transaction=params[:type_transaction]
    case type_transaction
    when '1'
      @transaction_type = "sacar"
      @action_controller = 'do_transaction'
      @transaction_name = "Saque"
    when '2'
      @transaction_type = "depositar"
      @action_controller = 'do_transaction'
      @transaction_name = "Depósito"
    else
      @transaction_type = "trasnferir"
      @action_controller = 'do_transaction'
      @transaction_name = "Transferência"
    end
  end
end
