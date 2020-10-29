# TASKS = [
#     { name:'create', description: 'fun video', completed_at: nil},
#     { name: 'study', description: 'week 1 rails', completed_at: nil},
#     { name: 'exercise', description: 'attend virtual yoga', completed_at: nil}
# ]

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = @tasks[task_id]
    if @task.nil?
      head :not_found
      return
    end
  end

end
