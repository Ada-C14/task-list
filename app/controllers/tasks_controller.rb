TASKS = [
    { type: "School", priority: "High" },
    { type: "Home", priority: "Medium" },
    { type: "Personal", priority: "Medium" }
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end

  def show
    task_id = params[:id].to_i
    @task = TASKS[task_id]
    if @task.nil?
      head :not_found
      return
    end
  end
end
