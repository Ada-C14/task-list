# TASKS = ["Wake up at 6am", "Let turkeys out of pen", "Collect chicken eggs", "Give baby Quail food and water", "Feed scraps to earth worms", "Make Breakfast", "Complete Ada Homework", "Have a growth mindset!"]

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to tasks_path
      return
    end
  end

  def update
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to :root
      return
    elsif @task.update(task_params)
      redirect_to task_path(@task.id)
      return
    else
      render :edit
      return
    end
  end

  def edit
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to tasks_path
      return
    end
  end

  def destroy
    task_id = params[:id].to_i
    task = Task.find_by(id: task_id)
    if task.delete
      redirect_to tasks_path
    else
      render :head, :bad_request
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
      render :new, :bad_request
    end
  end
end

private
def task_params
  return params.require(:task).permit(:name, :description, :completed_at)
end

def are_you_sure
  puts "Are you sure you would like to delete #{@task.name}?"

end