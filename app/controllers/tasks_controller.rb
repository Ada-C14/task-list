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
    # raise
    @task = Task.new(
        name: params[:task][:name],
        description: params[:task][:description],
        completed_at: nil
    )

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
    elsif @task.update(
        name: params[:task][:name],
        description: params[:task][:description],
        completed_at: params[:task][:completed_at]
    )
      render :index
      return
    else
      render :edit
      return
    end
  end

  def mark_complete
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      task_error_notice
      return
    else
      @task.update(
        # name: params[:task][:name],
        # description: params[:task][:description],
        completed_at: Time.now.strftime("%m/%d/%Y")
      )
    end

    render :index
    return
  end

  def mark_incomplete

  end

  def destroy

  end
end
