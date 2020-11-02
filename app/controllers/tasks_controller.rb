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
    @task = Task.new(task_params)
        # name: params[:task][:name],
        # description: params[:task][:description])

    if @task.save
      redirect_to task_path(@task.id)
      return
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
    elsif @task.update(task_params)
      redirect_to tasks_path
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

  def mark_complete
    @task = find_by_id

    if @task.completed_at.nil?
      @task.completed_at = Date.today
      @task.save
      redirect_to tasks_path
      return
    else
      @task.completed_at = nil
      @task.save
      redirect_to tasks_path
      return
    end
  end

  # helper method
  def find_by_id
    task_id = params[:id].to_i
    task = Task.find_by(id: task_id)
  end

  # strong params
  private
  def task_params
    return params.require(:task).permit(:name, :description, :completed_at)
  end

end
