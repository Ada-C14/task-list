class TasksController < ApplicationController
  def index
    @tasks = Task.all.sort
  end

  def show
    id = params[:id].to_i
    @task = Task.find(id)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(
      name: params[:task][:name],
      description: params[:task][:description],
      completed_at: params[:task][:completed_at])

    if @task.save
      redirect_to task_path(@task.id)
    else
      render :new, :bad_request
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      record_not_found
    end
    return
  end

  def update
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      record_not_found
      return
    elsif @task.update(
      name: params[:task][:name],
      description: params[:task][:description],
      completed_at: params[:task][:completed_at]
    )
      redirect_to tasks_path
     return
    else
      render :edit
      return
    end
  end

  def destroy
    task = Task.find_by(id: params[:id])
    if task.nil?
      record_not_found
      return
    else task.destroy
      redirect_to tasks_path
    end
  end

  def complete
    @task = Task.find_by(id: params[:id])
    if !(@task.completed_at.nil?)
      @task.update(completed_at: nil)
    elsif @task.completed_at.nil?
      @task.update(completed_at: Time.now.strftime("%a %b %d at %I:%M %p"))
    end
    redirect_to tasks_path
  end
end