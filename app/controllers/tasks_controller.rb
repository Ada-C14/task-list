# TASKS = ["groceries", "mop floor", "pay bills", "get a job"]

class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def show
    @task = find_by_id

    if @task.nil?
      redirect_to tasks_path
      return
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(
        name: params[:task][:name],
        description: params[:task][:description])

    if @task.save
      redirect_to task_path(@task.id)
    else
      render :new, :bad_request
    end
  end

  def edit
    @task = find_by_id

    if @task.nil?
      redirect_to tasks_path
      return
    end
  end

  def update
    @task = find_by_id

    if @task.nil?
      redirect_to tasks_path
      return
    end

    @task.name = params[:task][:name]
    @task.description = params[:task][:description]

    if @task.save
      redirect_to task_path(@task.id)
    else
      render :new, :bad_request
    end
  end

  def destroy
    @task = find_by_id

    if @task
      @task.destroy
      redirect_to tasks_path
      return
    else
      redirect_to tasks_path
      return
    end
  end

  # helper method
  def find_by_id
    task_id = params[:id].to_i
    task = Task.find_by(id: task_id)
  end

end
