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

  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description],
                     completed_at: params[:task][:completed_at])
    if @task.save
      redirect_to task_path(@task.id)
      return
    else
      redirect_to error_path, 'New task could not be created!'
      return
    end
  end
end