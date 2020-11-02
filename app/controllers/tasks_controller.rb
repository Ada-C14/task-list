class TasksController < ApplicationController

  before_action :find_task, except: [:index, :create]

  def index
    @tasks = Task.all.order("created_at")
  end

  def show
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
    @task = Task.new(task_params)

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

  def edit
    if @task.nil?
      redirect_to tasks_path
      return
    end
  end

  def update
    if @task.nil?
      redirect_to tasks_path
      return
    elsif @task.update(task_params)
      redirect_to tasks_path # go to the index so we can see the task in the list
      return
    else                # save failed
      render :edit      # show the new task form view again
      return
    end
  end

  def destroy
    if @task
      @task.destroy
      redirect_to tasks_path
    else
      head :not_found
    end
  end

  def complete
    if @task.nil?
      head :not_found
      return
    end

    if @task.completed_at.nil?
      @task.update(completed_at: Time.now)
    else
      @task.update(completed_at: nil)
    end
    redirect_to tasks_path
    return
  end


  private

  def find_task
    @task = Task.find_by(id: params[:id].to_i)
  end

  def task_params
    return params.require(:task).permit(:name, :description, :completed_at)
  end

end




