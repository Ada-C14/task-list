# TASKS = ["complete homework", "pick up groceries", "laundry", "meal prep", "pick up Mom"]

# TASKS = []

class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
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
    # @task = Task.new(
    #     name: params[:task][:name],
    #     description: params[:task][:description],
    #     completed_at: params[:task][:completed_at]
    # )
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = "Task was successfully added!"
      redirect_to task_path(@task.id)
    else
      flash.now[:error] = "Task was NOT successfully added :("
      render :new, :bad_request
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      # should I redirect to the index page?
      redirect_to tasks_path
    end
  end

  def update

    @task = Task.find_by(id: params[:id])

    if @task.nil?
      # redirect to the root page if given an invalid id
      redirect_to root_path
      return
    elsif @task.update(task_params)
      redirect_to task_path(@task.id)
      return
    else # save failed
      render :edit
      return
    end
  end

  def destroy
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      head :not_found
      return
    else
      @task.destroy
      redirect_to tasks_path
    end

  end

  def mark_complete
    # This is going above and beyond the examples, will also need to write controller tests
    # Add a button to the list of tasks on the home page, that will mark the task completed
    # Update the DB with the task's completed_at date

    # @task = Task.find_by(id: params[:id])
    #
    # if @task.nil?
    #   # redirect to the root page if given an invalid id
    #   redirect_to root_path
    #   return
    # else
    #   @task.update(completed_at: Time.now.strftime("%m/%d/%Y"))
    #   redirect_to tasks_path
    #   return
    # end


    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to root_path
    else
      # task.completed_at = Time.now.strftime("%m/%d/%Y")
      @task.update(completed_at: Time.now.strftime("%m/%d/%Y"))
      redirect_to tasks_path
    end


    # redirect_to tasks_path

  end

  private

  # strong params for the create and update actions
  def task_params
    return params.require(:task).permit(:name, :description, :completed_at)
  end

end
