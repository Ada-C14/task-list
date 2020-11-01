class TasksController < ApplicationController
  #Controller Actions are always methods
  def index #index means list all
    @tasks = Task.all
  end

  def show
    id = params[:id].to_i
    #@task = Task.find(id)
    @task = Task.find_by(id: id)
    if @task.nil?
      head :not_found
      return
    end
  end

  def update

  end

  def edit

  end

  def destroy

  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(
      name: params[:task][:name],
      description: params[:task][:description],
      completed_at: params[:task][:completed_at]
    )

    if task.save
      redirect_to task_path(task.id) # Send them to the '/tasks' path
    else
      render :new, :bad_request
    end
  end

end
