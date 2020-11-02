class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end


  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
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

    if @task.save
      redirect_to task_path(@task.id)
      return
    else
      render :new
      return
    end
  end

  def edit
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to tasks_path
      return
    end
  end

  def update
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to tasks_path
      return
    elsif @task.update(task_params)
      redirect_to task_path(@task)
      return
    else # if save failed
      redirect_to edit_task_path(@task)
      return
    end
  end

  def destroy
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task
      @task.destroy
    end

    redirect_to tasks_path
  end

  def toggle_complete
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to tasks_path
      return
    elsif @task.completed_at.nil?
      @task.update(completed_at: "#{Time.now.strftime("%I:%M %p %m/%d/%Y")}")
    else
      @task.update(completed_at: nil)
    end

    redirect_to tasks_path
  end


  private

  def task_params
    return params.require(:task).permit(:name, :description, :completed_at)
  end
end