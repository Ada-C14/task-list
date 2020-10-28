# TASKS = ["complete homework", "pick up groceries", "laundry", "meal prep", "pick up Mom"]

# TASKS = []

class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    # @task = TASKS[task_id]
    if @task.nil?
      # head :redirect
      redirect_to tasks_path
      # return
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
    if @task.save
      redirect_to task_path(@task.id)
    else
      render :new, :bad_request
    end
  end

  def edit
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    @task = Task.find_by(id: params[:id])

    if @task.nil?
      head :not_found
      # redirect_to task_path(@task.id)
    end
  end

  def update
    # task_id = params[:id]
    # edit_task = @task.where(id: task_id)
    # edit_task.name = params[:task][:name]
    # edit_task.description = params[:task][:description]
    # edit_task.completed_at = params[:task][:completed_at]
    #
    # if @task.save
    #   redirect_to task_path(@task.id)
    # else
    #   render :new, :bad_request
    # end


    @task = Task.find_by(id: params[:id])

    if @task.nil?
      head :not_found
      # redirect_to task_path(@task.id)
      return
    elsif @task.update(
        name: params[:task][:name],
        description: params[:task][:description],
        completed_at: params[:task][:completed_at]
    )
      redirect_to task_path(@task.id)
      return
    else # save failed
      render :edit
      return
    end


  end


  def destroy

  end

  def mark_completed

  end


end
