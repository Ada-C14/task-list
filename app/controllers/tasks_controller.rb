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
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to tasks_path
      return
    elsif !Task.exists?(task_id)
      redirect_to root_path
      return
    end
    render :show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params) #instantiate a new task
    if @task.save # save returns true if the database insert succeeds
      redirect_to task_path(@task.id) # go to the index so we can see the task in the list
      return
    else # save failed :(
    render :new # show the new task form view again
    return
    end
  end

  def edit
    @task = Task.find_by id: params[:id]

    if @task.nil?
      redirect_to root_path
      return
    end
  end

  def update
    @task = Task.find_by id: params[:id]
    if @task.nil?
      redirect_to root_path
      return
    elsif @task.update(task_params)
      redirect_to task_path(@task.id)
      return
    else
      render :edit
      return
    end
  end

  # app/controllers/tasks_controller.rb
  def destroy
    @task = Task.find_by(id: params[:id])

    if @task
      @task.destroy
      redirect_to root_path
    else
      head :not_found
      return
    end
  end

  def toggle_complete
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      head :not_found
      return
    elsif @task.completed_at.blank?
      @task.update(completed_at: Date.today.to_s)
    else
      @task.update(completed_at: nil)
    end
    redirect_to root_path
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :completed_at)
  end

end
