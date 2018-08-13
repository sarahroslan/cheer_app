class TasksController < ApplicationController
		before_action :set_task, except: [:index, :show]

	def new
		@task = Task.new
	end

	def create
		@task = current_user.tasks.new(task_params)

		respond_to do |f|
    f.html { redirect_to dashboard_path }
    f.js
  	end
	end

	def edit
		@task = Task.find(params[:id])
	end

	def update
		@task = Task.find(params[:id])
    	if @task.update(task_params)
      	redirect_to task_path 
    		
    	else
      	render 'edit'
    	end
  	
	end

	def show
		@task = Task.find(params[:id])
	end

	def index
		@incomplete_tasks = Task.where(status: false)
    @complete_tasks = Task.where(status: true)
    @tasks = Task.search(params[:term])

	end

	def destroy
		@task = Task.destroy(params[:id])
		@pending_tasks = current_user.tasks.order(updated_at: :desc).limit(5) 
		#redirect_to @task
		respond_to do |f|
    	f.html { redirect_to dashboard_path }
    	f.js
  	end
	end

	private

	def set_task
		@task = Task.search(params[:term])
	end

  def task_params
    params.require(:task).permit(:title, :description, :status, :term)
  end

  
end
