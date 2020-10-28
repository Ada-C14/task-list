require "time"
TASKS = [
    { name: "Do laundry", description: "Do the damn laundry", completed_at: Time.now},
    { name: "Do dishes", description: "Do the damn dishes", completed_at: Time.new(1989)},
    { name: "Cry in bed", description: "Waaahhh", completed_at: Time.new(1969)},
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
