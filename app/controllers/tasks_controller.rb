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

  def new
    @task = Task.new(name: parems[:task][:name], description: parems[:task][:description],
                     completed_at: parems[:task][:completed_at])
    if @task.save
      redirect_to tasks_path
      return
    else
      render :new
      return
  end
end