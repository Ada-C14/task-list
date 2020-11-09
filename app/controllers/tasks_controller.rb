class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to root_path
      return
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], completed_at: params[:task][:completed_at]) #instantiate a new book
    if @task.save # save returns true if the database insert succeeds
      redirect_to task_path(@task.id) # go to the index so we can see the book in the list
      return
    else # save failed :(
      render :new # show the new task form view again
      return
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to tasks_path
      return
    end
  end

  def update
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to root_path
    return
    elsif @task.update(
      name: params[:task][:name], 
      description: params[:task][:description], 
      completed_at: params[:task][:completed_at]
    )
      redirect_to task_path(@task.id) # go to the index so we can see the task in the list
      return
    else # save failed :(
      render :edit # show the new task form view again
      return
    end
  end


  private

  def task_params
    return params.require(:task).permit(:name, :description, :completed_at)
  end



end
