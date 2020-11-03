
class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to root_path
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(
        name: params[:task][:name],
        description: params[:task][:description]
    )
    if @task.save
      redirect_to task_path(@task.id)
    else
      render :new, :bad_request
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to root_path
      return
    end
  end

  def update
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to root_path
      return
    elsif @task.update(
        name: params[:task][:name],
        description: params[:task][:description],
        completed_at: params[:task][:completed_at]
    )
      redirect_to task_path(@task.id)
      return
    else
      render :edit, :bad_request
      return
    end
  end

  def destroy_confirmation

  end

  def destroy
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to root_path
      return
    else
      @task.destroy
      redirect_to tasks_path
    end
  end

  def mark_complete
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to root_path
      return
    end
    if @task.completed_at.nil?
      @task.update(
      completed_at: Time.now
    )
      redirect_to task_path(@task.id)
      return
    else
      @task.update(
        completed_at: nil
      )
      redirect_to task_path(@task.id)
      return
    end
  end

end
