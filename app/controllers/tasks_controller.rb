require "time"

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)

    redirect_to tasks_path and return if @task.nil?
  end

  def create
    task = Task.new(task_params)
    action_success_check(task.save, task_path(task.id))
  end

  def new
    @task = Task.new
  end

  def edit
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)

    redirect_to tasks_path and return if @task.nil?
  end

  def update
    task = Task.find_by(id: params[:id].to_i)

    redirect_to tasks_path and return if task.nil?

    action_success_check(task.update(task_params), task_path)
  end

  def destroy
    task_id = params[:id].to_i
    task = Task.find_by(id: task_id)

    redirect_to tasks_path and return if task.nil?

    action_success_check(task.destroy, tasks_path)
  end

  def complete
    task = Task.find_by(id: params[:id].to_i)

    redirect_to tasks_path and return if task.nil?

    if task.completed_at
      action_success_check(task.update(completed_at: nil), task_path)
    else
      action_success_check(task.update(completed_at: Time.current), task_path)
    end
  end

  private
  #add hard params?
  def action_success_check(action, redirect_path)
    if action
      redirect_to redirect_path
    else
      render :new, bad_request
    end
  end

  def task_params
    return params.require(:task).permit(:name, :description, :completed_at)
  end
end
