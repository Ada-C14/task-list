TASKS = %w[A B C D]

class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find_by(id: params[:id])
    unless @task
      redirect_to tasks_path(@task)
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

    result = @task.save

    if result
      redirect_to task_path(@task.id)
    else
      render :new
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
    end

    result = @task.update(
      {
        name: params[:task][:name],
        description: params[:task][:description],
        completed_at: params[:task][:completed_at]
      }
    )

    if result
      redirect_to tasks_path(@task.id) # params[:id])
    else
      render :edit
    end

  end

  def delete
    task = Task.find_by(id: params[:id])

    if task.nil?
      redirect_to root_path
      return

    elsif task.destroy
      redirect_to root_path
      return
    end
  end

  def confirm
    @task = Task.find_by(id: params[:id])
  end

  def complete
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to root_path
      return
    end

    if @task[:completed_at].nil? || @task[:completed_at] == ""
      @task.update(completed_at: Time.now)
      redirect_to root_path
      return
    else
      @task.update(completed_at: nil)
      redirect_to root_path
      return
    end

    redirect_to root_path
    return

  end

end


