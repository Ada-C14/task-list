# tasks controller class
class TasksController < ApplicationController
  # READ
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to root_path
      return
    end
  end

  # CREATE
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task.id)
      return
    else
      render :new
    return
    end
  end

  # UPDATE
  def edit
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to root_path
      return
    end
  end

  def update
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to root_path
      return
    end

    if @task.update(task_params)
      redirect_to task_path(@task.id)
      return
    else
      render :edit
      return
    end
  end

  # DESTROY
  def destroy
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    # NOTE: confirmation page is handled by index and show pages as a dialog box.
    if @task
      @task.destroy
      redirect_to tasks_path
    else
      head :not_found
      return
    end
  end

  def toggle_complete
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to root_path
      return
    end

    @task.completed_at = @task.completed_at.nil? ? Time.now.asctime : nil

    if @task.save
      redirect_to root_path
      return
    else
      head :not_found
      return
    end
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description)
  end
end
