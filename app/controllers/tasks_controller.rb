class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    id = params[:id].to_i
    @task = Task.find_by(id: id)
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
    if @task.save #save returns true if successful
      redirect_to task_path(@task.id)
      return
    else
      redirect_to :new
      return
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  def toggle_complete

  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :completed_at)
  end

end
