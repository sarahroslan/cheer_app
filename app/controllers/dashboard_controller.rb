class DashboardController < ApplicationController
	def index
		@user = current_user
		@tasks = Task.all
		@pending_tasks = current_user.tasks.order(updated_at: :desc).limit(5)
		@incomplete_tasks = Task.where(status: false)
    @complete_tasks = Task.where(status: true)
 	end


end
