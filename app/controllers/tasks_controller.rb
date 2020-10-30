class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    id = params[:id].to_i
    # if Task.find(id).nil?
    #   flash[:error] = "Item not found"
    # else
    @task = Task.find(id)
    # end

    # redirect_to tasks_path if @task.nil?

    # head :redirect if @task.nil?
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
end
