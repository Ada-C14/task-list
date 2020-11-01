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
    @task = Task.new(
      name: params[:task][:name],
      description: params[:task][:description],
      started_at: params[:task][:started_at],
      completed_at: params[:task][:completed_at]
    )
    if @task.save # save returns true if the database insert succeeds
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
    elsif @task.update(
      name: params[:task][:name],
      description: params[:task][:description],
      started_at: params[:task][:started_at],
      completed_at: params[:task][:completed_at]
    )
      redirect_to tasks_path # go to the index so we can see the book in the list
      return
    else
      # save failed :(
      render :edit # show the new book form view again
      return
    end
  end

  def destroy
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    if @task
      @task.destroy
      redirect_to tasks_path
    else
      render :notfound, status: :not_found
    end
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :started_at, :completed_at)
  end
end
