#
# TASKS = [
#     {todo: "Walk the dog"},
#     {todo: "Make the mung beans"},
#     {todo: "Go to the wine store"},
#     {todo: "Eat a vegetable"},
#     {todo: "Call your girl"}
# ]

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to tasks_path
      return
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description])
    if @task.save
      redirect_to task_path(@task.id)
      return
    else
      render :new, :bad_request
      return
    end
  end

  def update
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to tasks_path
      return
    elsif @task.update(
        name: params[:task][:name],
        description: params[:task][:description]
    )
      redirect_to task_path(@task.id)
      return
    else
      render :edit
      return
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to tasks_path
      return
    end

    @task.id = @task.id
    @task.description = @task.description
  end

  def destroy

  end

end
