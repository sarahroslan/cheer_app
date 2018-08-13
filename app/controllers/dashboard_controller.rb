class DashboardController < ApplicationController
	def index
		@user = current_user
		@tasks = Task.all
		@incomplete_tasks  = current_user.tasks.where(status: false).order(updated_at: :desc).limit(5)
    @complete_tasks = Task.where(status: true)
 	end


end
