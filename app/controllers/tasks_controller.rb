TASKS = ["Write Jeremy happy birthday", "Find credit card", "BECU Fraud", "Apple Care"]

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

end

