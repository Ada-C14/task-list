class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to tasks_path and return
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description])

    if @task.save
      redirect_to task_path(@task) and return
    else
      render :new and return
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to tasks_path and return
    end
  end

  def update
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to tasks_path and return
    elsif @task.update(
        name: params[:task][:name],
        description: params[:task][:description],
        completed_at: params[:task][:completed_at]
    )
      redirect_to tasks_path and return
    else
      render :edit
      return
    end
  end
end
