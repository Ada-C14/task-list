# TASKS = ["Do laundry", "Wash dogs", "Buy new sheets"]

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    if @task.nil?
      # head :temporary_redirect
      redirect_to root_path
      return
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(name: params[:task][:name],
                     description: params[:task][:description],
                     completed_at: params[:task][:completed_at]) #instantiate a new task
    if @task.save # save returns true if the database insert succeeds
      redirect_to task_path(@task.id)
      return
    else # save failed :(
    render :new # show the new task form view again
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

  def update
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      head :not_found
      return
    elsif @task.update(
        author: params[:task][:author],
        title: params[:task][:title],
        description: params[:task][:description]
    )
      redirect_to tasks_path # go to the index so we can see the task in the list
      return
    else # save failed :(
    render :edit # show the new task form view again
    return
    end
  end


end
