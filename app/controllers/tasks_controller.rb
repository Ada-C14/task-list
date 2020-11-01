class TasksController < ApplicationController
  def index
    @tasks = Task.order(id: :asc).all
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
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to root_path
      return
    end
  end

  def update
    @task = Task.find_by(id: params[:id])
    if @task
      @task.update(task_params)
      redirect_to task_path(@task.id)
      return
    else
      redirect_to root_path
      return
    end
  end

  def destroy
    @task = Task.find_by(id: params[:id])
    if @task
      @task.destroy
      redirect_to root_path
      return
    else
      head :not_found
      return
    end
  end

  def toggle_complete
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      head :not_found
      return
    else
      if @task.completed_at.nil?
        @task.update(completed_at: Time.now)
      else
        @task.update(completed_at: nil)
      end
      redirect_to root_path
      return
    end
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :completed_at)
  end

end
