# TASKS = ['eat', 'sleep', 'read', 'code']

class TasksController < ApplicationController


  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    #
    if @task.nil?
       redirect_to root_path
    end
  end

  def update
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to root_path
      # head :not_found
      return
    elsif  @task.update(
        name: params[:task][:name],
        description: params[:task][:description],
        completed_at: params[:task][:completed_at]
    )
      redirect_to task_path
      return
    else
      render :edit # show the new book form view again
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to tasks_path
      return
    end
  end

  def destroy
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      head :not_found
      return
    end

    @task.destroy

    redirect_to tasks_path
    return
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(name: params[:task][:name],
                     description: params[:task][:description],
                     completed_at: params[:task][:completed_at]) #instantiate a new book
    if @task.save # save returns true if the database insert succeeds
      redirect_to task_path(@task.id) # go to the index so we can see the task in the list
      #
    else # save failed :(
    render :new, :bad_request # show the new task form view again

    end
  end

  # def toggle_complete
  #   @task = Task.find(params[:id])
  #   @task.completed = true
  #   @task.save
  #   redirect_to current_user
  # end
  #
  # def incomplete
  #   @task = Task.find(params[:id])
  #   @task.completed = false
  #   @task.save
  #   redirect_to current_user
  # end
end
