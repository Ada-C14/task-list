TASKS = [ 
  { description: 'Make dinner', completed: false },
  { description: 'Drink my tea', completed: false },
  { description: 'Pay tuition', completed: false }
].freeze

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  # def show
  #   @task = Task.find(params[:id])
  #   if @task.nil?
  #     redirect_to action: "index"
  #   end
  # end
  #

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

  # def show
  #   task_id = params[:id].to_i
  #   @task = Task[task_id]
  #   if @task.nil?
  #     redirect_to root_path
  #     return
  #   end
  # end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description]) #instantiate a new task
    if @task.save # save returns true if the database insert succeeds
      redirect_to root_path # go to the index so we can see the book in the list
      return
    else # save failed :(
    render :new # show the new book form view again
    return
    end
  end

  # app/controllers/tasks_controller.rb
  # def destroy
  #   task_id = params[:id]
  #   @task = Task.find_by(id: task_id)
  #
  #   if @task
  #     @task.destroy
  #     redirect_to tasks_path
  #   else
  #     render :notfound, status: :not_found
  #   end
  # end

end
