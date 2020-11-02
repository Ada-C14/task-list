class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    begin
      @task = Task.find(task_id)
    rescue ActiveRecord::RecordNotFound
      redirect_to error_path(error: 'Task not found!')
      return
    end
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to error_path(error: 'Task to edit not found!')
    end
  end

  def create
    # @task = Task.new(name: params[:task][:name], description: params[:task][:description],
    #                  completed_at: params[:task][:completed_at])
    @task = Task.new(task_params) # Using strong params
    if @task.save
      redirect_to task_path(@task.id)
      return
    else
      redirect_to error_path(error: 'New task could not be created!')
      return
    end
  end

  def update
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to error_path(error: 'Task to update not found!')
      return
    # elsif @task.update(
    #     name: params[:task][:name],
    #     description: params[:task][:description],
    #     completed_at: params[:task][:completed_at]
    # )
    elsif @task.update(task_params) # Use strong params
      redirect_to task_path(@task.id)
      return
    else
      redirect_to error_path(error: 'Unable to update task!')
      return
    end

  end

  def destroy
    @task = Task.find_by(id: params[:id])

    if @task
      @task.destroy
      redirect_to tasks_path
    else
      redirect_to error_path(error: 'Can\'t find task to delete!')
    end
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :completed_at, :is_complete)
  end
end