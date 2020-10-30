class TasksController < ApplicationController
  #Controller Actions are always methods
  def index #index means list all
    @tasks = Task.all
  end

  def show
    id = params[:id].to_i
    @task = task[:id]

    if @task.nil?
      head :not_found
      return
    end
  end

end
