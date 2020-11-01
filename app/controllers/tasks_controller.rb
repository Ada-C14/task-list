class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      # head :not_found
      redirect_to tasks_path
      return
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task.id)
      return
    else
      render :new, :bad_request
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
      redirect_to tasks_path
      return
    elsif @task.update(task_params)
      redirect_to task_path(@task.id)
      return
    else
      render :edit
      return
    end
  end

  def destroy
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to tasks_path
      return
    end
    @task.destroy
    redirect_to tasks_path
    return
  end

  def complete
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to tasks_path
      return
    end

    if @task.completed_at.nil?
      @task.update_attribute(:completed_at, Time.now)
      redirect_to tasks_path
      return
    else
      @task.update_attribute(:completed_at, nil)
      redirect_to tasks_path
      return
    end
  end

  private
  def task_params
    return params.require(:task).permit(:name, :description, :completed_at)
  end
end
