class AccountsController < ApplicationController
  before_action :set_account
  before_action :get_transactions
  before_action :authenticate_active, except: [:show, :index, :switch]


  def index
  end

  def update
  end

  def show
  end

def switch
  @account.active = params[:active]
  respond_to do |format|
    if @account.save
      format.js
    else
      format.json { render json: @account.errors, status: :unprocessable_entity }
    end

    unless @account.active?
      sign_out
      render js: "window.location = '/accounts/index'"
    end
  end
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
      if params[:start_date].present?
        @dates = @account.transactions.where('DATE(date) between ? and ?',params[:start_date].to_date.strftime("%Y-%m-%d"), params[:end_date].to_date.strftime("%Y-%m-%d")).order(date: :desc).map{|x| x.date.strftime("%Y-%m-%d")}.uniq
        @transactions = @account.transactions.where('DATE(date) between ? and ?',params[:start_date].to_date.strftime("%Y-%m-%d"), params[:end_date].to_date.strftime("%Y-%m-%d")).order(id: :desc)
      else
        @dates = @account.transactions.where('date >= ?', 30.days.ago).order(date: :desc).map{|x| x.date.strftime("%Y-%m-%d")}.uniq
        @transactions = @account.transactions.where('date >= ?', 30.days.ago).order(id: :desc)
      end
    end

end
