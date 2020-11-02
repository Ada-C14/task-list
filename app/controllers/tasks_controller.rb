class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id] #we'll be able to access our route parameter via a special hash provided by Rails called params. The ID sent by the browser will be stored under the key :id (remember that this is the name we gave the parameter in the routefile).
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to '/tasks'
      return
    end
  end

  def new
    @task = Task.new
  end

  def create
    # @task = Task.new(name: params[:task])
    @task = Task.new(
      name: params[:task][:name],
      description: params[:task][:description],
      completed_at: params[:task][:completed_at]
    )
    # save returns true if new task successfully inserted in db
    if @task.save
      redirect_to task_path(@task.id) # take the user to the show page for the task that was just added
      return
    # save failed, task not inserted in db successfully
    else
      render :new # shows add new task form again to try again
      return
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to root_path
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
      redirect_to task_path(@task.id) # take the user to the show page for the task that was just updated
      return
    else
      render :edit # shows edit task form again to try again
      return
    end
  end

  def destroy
    task_id = params[:id]
    task_to_delete = Task.find_by(id: task_id) # find_by returns either a task (the model) or nil

    if task_to_delete.nil?
      head :not_found
      return
    else
      task_to_delete.destroy # nil.destroy would break code
      redirect_to tasks_path # go back to index action
    end
  end

end

