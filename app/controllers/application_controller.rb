class ApplicationController < ActionController::Base
	before_action :authenticate_user!
  helper_method :authenticate_active

	protect_from_forgery with: :exception
	skip_before_action :verify_authenticity_token

  def authenticate_active
    redirect_to accounts_path if !current_user.accounts.first.active
  end

end
