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
    @task = Task.new(
      name: params[:task][:name],
      completed_at: nil,
      description: params[:task][:description],
    )  #instantiate a new task

    if @task.save #true if the db insert succeeds
      redirect_to task_path(@task.id) # go to the new task page
      return
    else #save failed :/
      render :new #show new task form view again
    end
  end
  
  def edit
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to tasks_path
      return
    end
  end

  def update
    @task = Task.find_by(id: params[:id])

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
  

  def destroy
    @task = Task.find_by(id: params[:id])

    if @task.nil? 
      redirect_to root_path
      return
    end

    @task.destroy 
    redirect_to root_path
    return 
  end

  def toggle_complete 
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to root_path
      return 
    elsif @task.completed_at == nil
      @task.update(completed_at: Time.now) 
    else 
      @task.update(completed_at: nil)
    end 

    redirect_to root_path
    return
  end 

  private

  def task_params
    return params.require(:task).permit(:name, :description, :completed_at)
  end
end