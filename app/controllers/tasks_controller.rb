# TASKS = ["Wake up at 6am", "Let turkeys out of pen", "Collect chicken eggs", "Give baby Quail food and water", "Feed scraps to earth worms", "Make Breakfast", "Complete Ada Homework", "Have a growth mindset!"]

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

  def update

  end

  def edit

  end

  def destroy

  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(
      name: params[:task][:name],
      description: params[:task][:description])

    if @task.save
      redirect_to task_path(@task.id)
      return
    # else
    #   render :new, :redirect
    end
  end
end
