class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    begin
      @task = Task.find(task_id)
    rescue ActiveRecord::RecordNotFound
      redirect_to '/notfound'
      return
    end
  end
end