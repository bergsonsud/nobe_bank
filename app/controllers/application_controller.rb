class ApplicationController < ActionController::Base
	before_action :authenticate_user!
  	helper_method :authenticate_active

  def authenticate_active    
    redirect_to accounts_path if !current_user.accounts.first.active
  end
end
