TASKS = ["be cool", "be calm", "be collected", "lose your ever-loving mind"]

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
