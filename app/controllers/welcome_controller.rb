class WelcomeController < ApplicationController
	before_action :authenticate_active
end
