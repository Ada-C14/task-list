TASKS = %w[A B C D]

class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(
      name: params[:task][:name],
      description: params[:task][:description],
      completed_at: params[:task][:completed_at]
    )

    result = @task.save

    if result
      redirect_to tasks_path
    else
      render :new
    end
  end
end

