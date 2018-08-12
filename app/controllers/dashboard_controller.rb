class DashboardController < ApplicationController
	def index
		@user = current_user
		@tasks = Task.all
		

 	end
end
