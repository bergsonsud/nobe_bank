class TransactionsController < ApplicationController
  before_action :set_account, only: [:do_transaction]
  before_action :set_tax, only: [:transaction, :do_transaction]
  before_action :set_value, only: [:do_transaction]
  before_action :transaction_name

  def index
  end

  def transaction
    @transaction = Transaction.new
  end

  def do_transaction
    @transaction = Transaction.new(
      :account_id => @account_id,
      :type_transaction => params[:type_transaction].to_i,
      :tax => params[:tax_calc].to_i+params[:extra].to_i,
      :value => @value,
      :description => params[:description],
      :date => Date.parse(params[:date]))


    respond_to do |format|
      if @transaction.save
        format.json { head :no_content }
        format.html
      else
        format.html { render :transaction }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def transfer
  end

  def calc_tax
    if params[:type_transaction] == '3'
      calc
    else
      0
    end
  end


  def calc
    #helper days = {0 => "Sunday",1 => "Monday", 2 => "Tuesday",3 => "Wednesday",4 => "Thursday",5 => "Friday",6 => "Saturday"}
    today = Time.zone.now.wday
    hour = Time.zone.now.hour
    if today.between?(1,6) and hour.between?(9,18)
      return 5
    else
      return 7
    end
  end


private
  def set_account
      @account_id = current_user.accounts.first.id
  end

  def set_tax
    @tax = calc_tax
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
      @transaction_type = "transferir"
      @action_controller = 'do_transaction'
      @transaction_name = "Transferência"
    end
  end
end
