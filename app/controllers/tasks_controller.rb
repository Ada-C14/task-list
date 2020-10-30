class TasksController < ApplicationController
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
      flash[:notice] = "oops! that task does not exist..."
      redirect_to tasks_path
      return
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  def mark_complete

  end

  def mark_incomplete

  end
end
