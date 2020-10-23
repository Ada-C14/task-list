require "date"

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)

    if @task.nil?
      head :not_found
      return
    end
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(task_params)

    if task.save
      redirect_to task_path(task.id)
      return
    else
      render :new, :bad_request
      return
    end
  end

  def edit
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)

    if @task.nil?
      head :not_found
      return
    else
      @task.name = @task[:name]
      @task.description = @task[:description]
      @task.completed_at = @task[:completed_at]
    end
  end

  def update
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)

    if @task.nil?
      head :not_found
      return
    elsif @task.update(task_params)
      redirect_to task_path(@task.id)
      return
    else
      render :new, :bad_request
      return
    end
  end

  def destroy
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      head :not_found
      return
    else
      @task.destroy
      redirect_to root_path
      return
    end
  end

  def mark_complete
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)

    if @task.nil?
      head :not_found
      return
    end

    if @task[:completed_at].empty?
      @task[:completed_at] = Date.today.to_s
    end

    if @task.save
      redirect_to root_path
      return
    else
      render :new, :bad_request
      return
    end
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :completed_at)
  end
end
