class TasksController < ApplicationController
  #Controller Actions are always methods
  def index #index means list all
    @tasks = Task.all
  end

  def show
    id = params[:id].to_i
    #@task = Task.find(id)
    @task = Task.find_by(id: id)
    if @task.nil?
      head :not_found
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

  end

  def create

  end

end
