# TASKS = [
#     {description: "pay bills", date: "10/12", priority: "high"},
#     {description: "shopping", date: "10/25", priority: "low"},
#     {description: "homework", date: "10/30", priority: "high"}
# ]


class TasksController < ApplicationController


  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    if @task.nil?
      head :not_found
      return
    end
  end

  def update
  end

  def edite
  end

  def destroy
  end

  def new
  end

  def create
  end

end
