class TasksController < ApplicationController

  def index
    @tasks = Task.all.order(:id)
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to task_not_found_path
      return
    end

  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save # save returns true if the database insert succeeds
      redirect_to task_path(@task) # go to the index so we can see the task in the list
      return
    else # save failed :(
      render :new # show the new task form view again
      return
    end
  end

  def edit
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to task_not_found_path
      return
    else
      render :new
      return
    end
  end

  def update
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to root_path
      return
    elsif @task.update(task_params)
      redirect_to task_path(@task)
      return
    else
      render :new
      return
    end
  end

  def destroy
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to task_not_found_path
      return
    elsif @task.destroy
      redirect_to tasks_path
      return
    else
      redirect_to task_path(@task)
      return
    end
  end

  def toggle_complete
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to task_not_found_path
      return
    else
      if @task.completed_at
        @task.update(completed_at: nil)
        redirect_to task_path(@task.id)
      elsif @task.completed_at.nil?
        @task.update(completed_at: Time.now)
        redirect_to task_path(@task.id)
      else
        render :show
      end
      return
    end
  end

  def not_found
    render :template => 'tasks/not_found', :status => :not_found
    return
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :completed_at)
  end

end
