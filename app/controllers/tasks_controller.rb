class TasksController < ApplicationController
  TASKS = [
      {description: "pay bills", date: "10/12", priority: "high"},
      {description: "shopping", date: "10/25", priority: "low"},
      {description: "homework", date: "10/30", priority: "high"}
  ]

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
