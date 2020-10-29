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
      redirect_to action: "show"
      return
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(
        name: params[:task][:name],
        description: params[:task][:description],
        completed_at: params[:task][:completed_at])
    if @task.save
      redirect_to task_path(@task.id) #send the user to the /tasks path
      return
    else
      render :new, :bad_request
    end
  end

  def update
  end

  def edite
  end

  def destroy
  end





end
