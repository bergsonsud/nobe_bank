class WelcomeController < ApplicationController
	before_action :authenticate_active

	def index
	end
end
