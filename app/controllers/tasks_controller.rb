class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    id = params[:id].to_i
    @task = Task.find(id)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(
      name: params[:task][:name],
      description: params[:task][:description],
      completed_at: params[:task][:completed_at])

    if @task.save
      redirect_to task_path(@task.id)
    else
      render :new, :bad_request
    end
  end

  def edit
    # @task = Task.find_by(id: params[id])
  end
end
