# TASKS = ["complete homework", "pick up groceries", "laundry", "meal prep", "pick up Mom"]

# TASKS = []

class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    # @task = TASKS[task_id]
    if @task.nil?
      head :redirect
      return
    end
  end

  def new

  end

  def update

  end

  def edit

  end

  def create

  end

  def destroy

  end

  def mark_completed

  end


end
