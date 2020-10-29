TASKS = [
    {item: "wash dog"},
    {item: "wash dishes"},
    {item: "wash hair"}
]

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id:task_id)
  end
end
