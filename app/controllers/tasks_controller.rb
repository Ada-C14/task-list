# TASKS = [ "Buy groceries", "Take out the trash", "Take the dog for a walk", "Do laundry"  ]


class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(description: params[:task][:description],
                     name: params[:task][:name],
                     completed_at: params[:task][:completed_at]) #instantiate a new task
    if @task.save # save returns true if the database insert succeeds
      redirect_to task_path(@task.id) # go to the index so we can see the book in the list
      return
    else # save failed :(
      render :new # show the new task form view again
      return
    end
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to tasks_path
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
      redirect_to root_path
      return
    elsif @task.update(
        description: params[:task][:description],
        name: params[:task][:name],
        completed_at: params[:task][:completed_at]
    )
      redirect_to tasks_path # go to the index so we can see the task in the list
      return
    else # save failed :(
    render :edit # show the new book form view again
    return
    end
  end

  def destroy
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task
      @task.destroy
      redirect_to tasks_path
    else
      head :not_found
      return
    end
  end

end
