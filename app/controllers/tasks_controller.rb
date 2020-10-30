require "time"

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to tasks_path
    end
  end

  def create
    task = Task.new(name: params[:task][:name], description: params[:task][:description])

    if task.save
      redirect_to task_path(task.id)
    else
      render :new, bad_request
    end
  end

  def new
    @task = Task.new
  end

  def edit
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to tasks_path
    end
  end

  def update
    task = Task.find_by(id: params[:id].to_i)
    if task.nil?
      redirect_to tasks_path
    elsif task.update name: params[:task][:name], description: params[:task][:description]
      redirect_to task_path
    else
      render :new, bad_request
    end
  end

  def destroy
    task_id = params[:id].to_i
    task = Task.find_by(id: task_id)
    if task.nil?
      redirect_to tasks_path
    elsif task.destroy
      redirect_to tasks_path
    else
      render :new, bad_request
    end
  end
end
