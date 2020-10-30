class TasksController < ApplicationController
  #controller Actions are always methods!
  def index #index means list all
    @tasks = Task.all
  end

  def show
    id = params[:id]
    @task = Task.find(id)

    if @task.nil?
      head :not_found #can redirect to 404 page instead here
      return
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description])
    if @task.save #is true
      redirect_to tasks_path
      return
    else #save failed
      render :new, :bad_request #show the new task form
      return
    end
  end

  #to complete a task, you will want to give the time.now here
end
