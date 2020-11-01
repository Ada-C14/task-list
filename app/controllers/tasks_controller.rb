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
      # head :not_found
      head :temporary_redirect
      return
    end
  end

  def update
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      head :not_found
      return
    elsif @task.update(
        name: params[:task][:name],
        description: params[:task][:description],
        completed_at: params[:task][:completed_at]
    )
      redirect_to tasks_path # go to the index so we can see the task in the list
      return
    else # save failed :(
    render :edit # show the new task form view again
    return
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      head :not_found
      return
    end
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
