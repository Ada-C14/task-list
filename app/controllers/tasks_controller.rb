class TasksController < ApplicationController
  # Helper Methods
  def task_error_notice
    flash[:notice] = "oops! that task does not exist..."
    redirect_to tasks_path
  end

  #########################################################

  # Main CRUD actions
  def index
    @tasks = Task.all
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

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      task_error_notice
      return
    end
  end

  def edit
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)

    if @task.nil?
      task_error_notice
      return
    end
  end

  def update
    # raise
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      task_error_notice
      return
    elsif @task.update(task_params)
      redirect_to tasks_path
      return
    else
      render :edit
      return
    end
  end

  def toggle_completion
    # raise
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      task_error_notice
      return
    elsif @task.completed_at.blank?
      @task.update(
        completed_at: Time.now.strftime("%m/%d/%Y")
      )
    else
      @task.update(
          completed_at: nil
      )
    end

    render :index
    return
  end

  def destroy
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      task_error_notice
      return
    else
      @task.destroy
    end

    redirect_to tasks_path
    return
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :completed_at)
  end
end
