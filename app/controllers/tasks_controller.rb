class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find_by(id: params[:id])
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
      redirect_to "/tasks/#{Task.last.id}"
      return
    else
    render :new
    return
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      head :not_found
      return
    end
  end

  def update
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to root_path
      return
    elsif @task.update(task_params)
      redirect_to task_path
      return
    else
      render :edit
    end
  end

  def destroy
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      head :not_found
      return
    end

    @task.destroy
    redirect_to root_path
    return
  end

  def mark
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      head :not_found
      return
    end
    if @task.completed_at == nil || @task.completed_at == ""
      @task.completed_at = Time.now
      @task.save
    else
      @task.completed_at = nil
      @task.save
    end

    redirect_to root_path
    return
  end

  private
  def task_params
    return params.require(:task).permit(:name, :description, :completed_at)
  end
end
