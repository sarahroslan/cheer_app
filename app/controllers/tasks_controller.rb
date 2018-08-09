class TasksController < ApplicationController

	def new
		@task = Task.new
	end

	def create
		@task = current_user.tasks.new(task_params)

		if @task.save
			flash[:notice] = "Task saved"
			redirect_to tasks_path
		else
			redirect_to new_task_path
		end
	end

	def edit
		@task = Task.find(params[:id])
	end

	def update
		@task = Task.find(params[:id])
    	if @task.update(task_params)
      	redirect_to @task
    	else
      	render 'edit'
    	end
  	
	end

	def show
		@task = Task.find(params[:id])
	end

	def index
			@incomplete_tasks = Task.where(complete: false)
    	@complete_tasks = Task.where(complete: true)
    	@tasks = Task.all
	end

	def destroy
		@task = Task.destroy(params[:id])
		redirect_to @task
	end

	private

  def task_params
    params.require(:task).permit(:title, :description, :status)
  end
end
