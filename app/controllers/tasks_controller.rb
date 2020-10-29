TASKS = [ 
  { description: 'Make dinner', completed: false },
  { description: 'Drink my tea', completed: false },
  { description: 'Pay tuition', completed: false }
].freeze

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    if !Task.exists?(task_id)
      redirect_to root_path
      return
    end
    @task = Task.find(params[:id].to_i)
    if @task.nil?
      redirect_to root_path
      return
    end
    render :show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], completed_at: params[:task][:completed_at]) #instantiate a new task
    if @task.save # save returns true if the database insert succeeds
      redirect_to task_path(@task.id) # go to the index so we can see the task in the list
      return
    else # save failed :(
    render :new # show the new task form view again
    return
    end
  end

  # app/controllers/tasks_controller.rb
  def destroy
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task
      @task.destroy
      redirect_to task_path(@task.id)
    else
      render :notfound, status: :not_found
    end
  end

end
