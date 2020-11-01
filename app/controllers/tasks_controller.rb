require 'time'


class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = find_by
    if @task.nil?
      redirect_to tasks_path
      return
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to task_path(@task.id)
      return
    else
      render :new, :bad_request
      return
    end
  end

  def update
    @task = find_by

    if @task.nil?
      redirect_to tasks_path
      return
    elsif @task.update(
        name: params[:task][:name],
        description: params[:task][:description]
    )
      redirect_to task_path(@task.id)
      return
    else
      render :edit
      return
    end
  end

  def edit
    @task = find_by

    if @task.nil?
      redirect_to tasks_path
      return
    end

    @task.id = @task.id
    @task.description = @task.description
  end

  def destroy
    task_id = find_by
    @task = find_by

    if @task
      @task.destroy
      redirect_to tasks_path
    else
      render :notfound, status: :not_found
    end
  end

  def complete
    @task = find_by

    if @task.nil?
      head :not_found
      redirect_to tasks_path
      return
    else
      t = Time.now
      formatted_time = t.strftime("%m/%d/%Y, %I:%M %p")
      @task.update(completed_at: formatted_time)
      redirect_to tasks_path
      return
    end
  end

  def find_by
    task_id = params[:id].to_i
    task = Task.find_by(id: task_id)
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description)
  end
end
