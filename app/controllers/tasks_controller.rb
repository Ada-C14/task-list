# TASKS = [
#     { type: "School", priority: "High" },
#     { type: "Home", priority: "Medium" },
#     { type: "Personal", priority: "Medium" }
# ]

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new

  end

  def create

  end

  def show
    task_id = params[:id].to_i
    @task = Task.find(task_id)
    if @task.nil?
      head :not_found
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
end
