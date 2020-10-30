# TASKS = [
#     { name:'create', description: 'fun video', completed_at: nil},
#     { name: 'study', description: 'week 1 rails', completed_at: nil},
#     { name: 'exercise', description: 'attend virtual yoga', completed_at: nil}
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
    #instantiate a new task
    @task = Task.new(
        name: params[:task][:name],
        description: params[:task][:description],
        completed_at: params[:task][:completed_at])

    # save returns true if the database insert succeeds
    if @task.save
      # go to the index so we can see the task in the list, send them back to '/tasks' path
      redirect_to task_path(@task.id)
      return
    else                              # save failed
      render :new, :bad_request       #show the new task form view again
      return
    end
  end

end
