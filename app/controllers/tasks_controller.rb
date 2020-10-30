class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    # @task = Task.new(name: params[:task][:name], description: params[:task][:description])
    #
    # if @task.save
    #   redirect_to tasks_path
    #   return
    # else
    #   render :new
    #   return
    # end
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find(task_id)
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

  def mark_complete

  end

  def mark_incomplete

  end
end
