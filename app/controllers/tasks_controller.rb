class TasksController < ApplicationController
		before_action :set_task, except: [:index, :show, :update_status]

	def new
		@task = Task.new
	end

	def create
		@task = current_user.tasks.new(task_params)
		if @task.save
			redirect_to dashboard_path
		else 
    	redirect_to dashboard_path
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
		if params[:term]
    	@tasks = current_user.tasks.search(params[:term])
    else
    	@tasks = Task.all
    end
	end

	def destroy
		@task = Task.destroy(params[:id])
		@incomplete_tasks  = current_user.tasks.where(status: false).order(updated_at: :desc).limit(5)
		#redirect_to @task
		respond_to do |f|
    	f.html { redirect_to dashboard_path }
    	f.js
  	end
	end

	def update_status
		task = Task.find(params[:id])
		task.done
		redirect_to dashboard_path
	end

	private

	def set_task
		@task = Task.search(params[:term])
	end

  def task_params
    params.require(:task).permit(:title, :description, :status, :term, )
  end

  
end
