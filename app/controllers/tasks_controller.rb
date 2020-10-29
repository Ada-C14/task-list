TASKS = ["Wake up at 6am", "Let turkeys out of pen", "Collect chicken eggs", "Give baby Quail food and water", "Feed scraps to earth worms", "Make Breakfast", "Complete Ada Homework", "Have a growth mindset!"]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      head :not_found
      return
    end
  end

  def update

  end

  def edit

  end

  def destroy

  end

  def new

  end

  def create

  end
end
