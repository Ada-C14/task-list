# TASKS = [ "Buy groceries", "Take out the trash", "Take the dog for a walk", "Do laundry"  ]


class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create

  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      head :not_found
      return
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

end
