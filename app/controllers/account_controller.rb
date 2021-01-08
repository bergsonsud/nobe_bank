class AccountController < ApplicationController
  before_action :set_account
  before_action :get_transactions

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(:user_id => current_user.id, :amount => 0)
    respond_to do |format|
      if @account.save
        format.json { head :no_content }
        format.html
      else
        format.json { render json: @account.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def update
  end

  def swtich
  end



  def reports
  end

  def amount
  end

  private
    def set_account
      @account_id = current_user.accounts.first.id
      @account = Account.find(@account_id)
    end

    def get_transactions      
      @dates = @account.transactions.where('date >= ?', 30.days.ago).order(date: :desc).map{|x| x.date}.uniq
      @transactions = @account.transactions.where('date >= ?', 30.days.ago).order(id: :desc)      
    end

end
