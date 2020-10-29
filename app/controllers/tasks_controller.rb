class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)

    if @task.nil?
      head 302
      return
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(
        name: params[:task][:name], #what is params again? the request parameter built in rails?
        description: params[:task][:description],
        completed_at: params[:task][:completed_at]
    )

    if @task.save
      redirect_to task_path(@task)
    else
      render :new, :bad_request
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      head 302
      return
    end
  end

  def update
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      head 302
      return
    elsif @task.update(
        name: params[:task][:name],
        description: params[:task][:description],
        completed_at: params[:task][:completed_at]
    )
      redirect_to tasks_path
      return
    else
      render :edit
    end
  end
end
