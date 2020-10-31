class TasksController < ApplicationController

  def index
    @tasks = Task.all
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
    @task = Task.new(
        name: params[:task][:name],
        description: params[:task][:description],
        completed_at: params[:task][:completed_at]
    )
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
    elsif @task.update(
      name: params[:task][:name],
      description: params[:task][:description],
      completed_at: params[:task][:completed_at]
    )
      redirect_to task_path(@task)
      return
    else
      render :edit
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

  # def mark_complete
  #   task_id = params[:id]
  #   @task = Task.find_by(id: task_id)
  #
  #   if @task.nil?
  #     redirect_to task_not_found_path
  #     return
  #   else
  #     @task.update(name: params[:task][:name], description: params[:task][:description], completed_at: Time.now)
  #     redirect_to task_path(@task)
  #     return
  #   end
  # end

  def not_found
    render :template => 'tasks/not_found',:status => :not_found
    return
  end

end
